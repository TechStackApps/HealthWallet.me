import 'dart:convert';

import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/records/data/datasource/fhir_resource_datasource.dart';
import 'package:health_wallet/features/records/data/mapper/display_factory_manager.dart';
import 'package:health_wallet/features/records/data/mapper/fhir_resource_mapper.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/features/records/presentation/models/encounter_display_model.dart';
import 'package:health_wallet/features/records/presentation/models/fhir_resource_display_model.dart';
import 'package:health_wallet/features/records/presentation/models/timeline_resource_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RecordsRepository)
class RecordsRepositoryImpl implements RecordsRepository {
  final FhirResourceDatasource _datasource;
  final DisplayFactoryManager _displayFactory;
  final FhirResourceMapper _mapper;

  final Map<String, List<TimelineResourceModel>> _timelineCache = {};
  final Map<String, Map<String, List<FhirResourceDisplayModel>>>
      _encounterRelatedCache = {};
  final Map<String, DateTime> _cacheTimestamps = {};

  static const Duration _cacheExpiry = Duration(minutes: 10);
  static const int _pageSize = 20;

  int _currentPage = 0;
  bool _hasMorePages = true;

  int get currentPage => _currentPage;

  @override
  bool get hasMorePages => _hasMorePages;

  RecordsRepositoryImpl(AppDatabase database)
      : _datasource = FhirResourceDatasource(database),
        _displayFactory = DisplayFactoryManager(),
        _mapper = const FhirResourceMapper();

  @override
  void reset() {
    _currentPage = 0;
    _hasMorePages = true;
    _clearAllCaches();
  }

  @override
  Future<List<TimelineResourceModel>> getTimelineResources({
    List<String> resourceTypes = const [],
    bool loadMore = false,
    String? sourceId,
  }) async {
    if (loadMore) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }

    logger.d(
        'RecordsRepository: Getting timeline resources - page: $_currentPage');

    final cacheKey =
        'timeline_${resourceTypes.join('_')}_${sourceId ?? 'all'}_$_currentPage';

    // Check cache first
    if (_isCacheValid(cacheKey)) {
      logger.d('RecordsRepository: Returning cached timeline resources');
      return _timelineCache[cacheKey]!;
    }

    try {
      final timelineResources = <TimelineResourceModel>[];
      final offset = _currentPage * _pageSize;

      // Use default resource types if none specified
      final targetResourceTypes = resourceTypes.isEmpty
          ? [
              'Encounter',
              'AllergyIntolerance',
              'Condition',
              'Procedure',
              'MedicationRequest',
              'Observation',
              'DiagnosticReport',
              'Immunization',
              'CarePlan',
              'Goal',
              'DocumentReference',
              'Media',
              'Patient',
              'Practitioner',
              'Organization',
              'Location',
            ]
          : resourceTypes;

      // Load encounters
      if (targetResourceTypes.contains('Encounter')) {
        final encounters =
            await _getEncountersPaginated(offset, _pageSize, sourceId);
        for (final encounter in encounters) {
          timelineResources.add(TimelineResourceModel.fromEncounter(encounter));
        }
      }

      // Load standalone resources
      final standaloneTypes =
          targetResourceTypes.where((type) => type != 'Encounter').toList();
      if (standaloneTypes.isNotEmpty) {
        final standaloneResources = await _getStandaloneResourcesPaginated(
            standaloneTypes, offset, _pageSize, sourceId);
        for (final resource in standaloneResources) {
          timelineResources
              .add(TimelineResourceModel.fromStandaloneResource(resource));
        }
      }

      // Sort by timestamp (newest first)
      timelineResources.sort((a, b) {
        final aTimestamp = a.timestamp;
        final bTimestamp = b.timestamp;

        if (aTimestamp == null && bTimestamp == null) return 0;
        if (aTimestamp == null) return 1;
        if (bTimestamp == null) return -1;

        return bTimestamp.compareTo(aTimestamp);
      });

      _hasMorePages = timelineResources.length == _pageSize;

      // Cache the results
      _timelineCache[cacheKey] = timelineResources;
      _cacheTimestamps[cacheKey] = DateTime.now();

      logger.d(
          'RecordsRepository: Loaded ${timelineResources.length} timeline resources');
      return timelineResources;
    } catch (e, stack) {
      logger.e('RecordsRepository: Error loading timeline resources', e, stack);
      rethrow;
    }
  }

  /// Get encounters with pagination and proper display models
  Future<List<EncounterDisplayModel>> _getEncountersPaginated(
      int offset, int limit, String? sourceId) async {
    final encounters = await _datasource.getAllResources(
      'Encounter',
      limit: limit,
      offset: offset,
      sourceId: sourceId,
    );

    final displayModels = <EncounterDisplayModel>[];
    for (final encounter in encounters) {
      // Resolve relationships
      final enrichedEncounter = await _enrichEncounter(encounter);

      // Build display model from enriched encounter
      final displayModel = _buildEncounterDisplayModel(enrichedEncounter);
      displayModels.add(displayModel);
    }

    return displayModels;
  }

  /// Get standalone resources with improved filtering logic (like backup version)
  Future<List<FhirResourceDisplayModel>> _getStandaloneResourcesPaginated(
      List<String> resourceTypes,
      int offset,
      int limit,
      String? sourceId) async {
    final standaloneResources = <Map<String, dynamic>>[];

    for (final resourceType in resourceTypes) {
      // Get resources of this type with pagination
      final resources = await _datasource.getAllResources(
        resourceType,
        limit: limit,
        offset: offset,
        sourceId: sourceId,
      );

      // Apply improved filtering logic (like backup version)
      for (final resource in resources) {
        if (_isStandaloneResource(resource)) {
          standaloneResources.add(resource);
        }
      }
    }

    // Sort by date (newest first)
    standaloneResources.sort((a, b) {
      final aDate = _extractResourceDate(a);
      final bDate = _extractResourceDate(b);

      if (aDate == null && bDate == null) return 0;
      if (aDate == null) return 1;
      if (bDate == null) return -1;

      try {
        return DateTime.parse(bDate).compareTo(DateTime.parse(aDate));
      } catch (_) {
        return 0;
      }
    });

    // Build display models using factory pattern
    final displayModels = <FhirResourceDisplayModel>[];
    for (final resource in standaloneResources.take(limit)) {
      final displayModel = _displayFactory.buildDisplayModel(resource);
      displayModels.add(displayModel);
    }

    return displayModels;
  }

  /// Improved standalone resource detection (like backup version)
  bool _isStandaloneResource(Map<String, dynamic> resource) {
    final resourceType = resource['resourceType'] as String?;

    // Structural resources always appear in main timeline (like backup version)
    const structuralResourceTypes = {
      'Patient',
      'Practitioner',
      'Organization',
      'Location'
    };

    if (structuralResourceTypes.contains(resourceType)) {
      return true; // Always show structural resources
    }

    // For medical resources, check if they reference any encounter
    // Use the more robust encounter reference detection
    return !_referencesAnyEncounter(resource);
  }

  @override
  Future<Map<String, List<FhirResourceDisplayModel>>>
      getRelatedResourcesForEncounter(
    String encounterId,
  ) async {
    logger.d(
        'RecordsRepository: Getting related resources for encounter $encounterId');

    // Check cache first
    if (_encounterRelatedCache.containsKey(encounterId)) {
      logger.d('RecordsRepository: Returning cached related resources');
      return _encounterRelatedCache[encounterId]!;
    }

    try {
      final resourceTypes = [
        'Observation',
        'AllergyIntolerance',
        'MedicationRequest',
        'Condition',
        'Procedure',
        'Immunization',
        'DiagnosticReport',
        'DocumentReference',
        'Claim',
        'ExplanationOfBenefit',
        'CarePlan',
        'Goal',
        'Media',
        'Patient',
        'Practitioner',
        'Organization',
        'Location',
        'Medication',
      ];

      final relatedResourcesByType = <String, List<FhirResourceDisplayModel>>{};

      // First, get the encounter to check what it references (like backup version)
      final encounter = await _datasource.getResource('Encounter', encounterId);

      for (final resourceType in resourceTypes) {
        final resources = await _datasource.getAllResources(resourceType);
        final relatedResources = <Map<String, dynamic>>[];

        for (final resource in resources) {
          // Check if resource references the encounter (standard way)
          bool referencesEncounter =
              _referencesEncounter(resource, encounterId);

          // Also check if the encounter references this resource (reverse relationship)
          bool referencedByEncounter = encounter != null &&
              _isReferencedByEncounter(resource, encounter);

          if (referencesEncounter || referencedByEncounter) {
            relatedResources.add(resource);
          }
        }

        if (relatedResources.isNotEmpty) {
          // Sort by date (newest first)
          relatedResources.sort((a, b) {
            final aDate = _extractResourceDate(a);
            final bDate = _extractResourceDate(b);

            if (aDate == null && bDate == null) return 0;
            if (aDate == null) return 1;
            if (bDate == null) return -1;

            try {
              return DateTime.parse(bDate).compareTo(DateTime.parse(aDate));
            } catch (_) {
              return 0;
            }
          });

          // Build display models using factory pattern
          final displayModels = relatedResources
              .map((resource) => _displayFactory.buildDisplayModel(resource))
              .toList();

          relatedResourcesByType[resourceType] = displayModels;
        }
      }

      // Cache the results
      _encounterRelatedCache[encounterId] = relatedResourcesByType;

      logger.d(
          'RecordsRepository: Loaded related resources for encounter $encounterId: ${relatedResourcesByType.keys.join(', ')}');
      return relatedResourcesByType;
    } catch (e, stack) {
      logger.e('RecordsRepository: Error getting related resources', e, stack);
      rethrow;
    }
  }

  @override
  Future<List<String>> getAvailableResourceTypes() async {
    return await _datasource.getAvailableResourceTypes();
  }

  @override
  Future<Map<String, int>> importFhirBundle(
      String bundleJson, String defaultSourceId) async {
    _clearAllCaches();

    // Parse and import bundle with individual source IDs
    final resources = _parseBundleResourcesWithSourceIds(bundleJson);
    final summary = <String, int>{};

    logger.d('--- Starting bundle import with individual source IDs ---');
    logger.d('Default source ID: $defaultSourceId');

    for (final entry in resources.entries) {
      final resourceType = entry.key;
      final resourceList = entry.value;

      // Group resources by their individual source IDs
      final resourcesBySourceId = <String, List<Map<String, dynamic>>>{};

      for (final resource in resourceList) {
        final resourceSourceId =
            resource['_sourceId'] as String? ?? defaultSourceId;

        // Remove the temporary _sourceId field from the resource
        final cleanResource = Map<String, dynamic>.from(resource);
        cleanResource.remove('_sourceId');

        resourcesBySourceId.putIfAbsent(resourceSourceId, () => []);
        resourcesBySourceId[resourceSourceId]!.add(cleanResource);
      }

      // Insert resources grouped by their source IDs
      for (final sourceEntry in resourcesBySourceId.entries) {
        final sourceId = sourceEntry.key;
        final sourceResources = sourceEntry.value;

        logger.d(
            'Inserting ${sourceResources.length} $resourceType resources with source ID: $sourceId');

        await _datasource.bulkInsertResources(
            resourceType, sourceResources, sourceId);
      }

      summary[resourceType] = resourceList.length;
    }

    logger.d('--- Bundle import completed ---');
    return summary;
  }

  // Helper methods

  /// Enrich encounter with resolved relationships
  Future<Map<String, dynamic>> _enrichEncounter(
      Map<String, dynamic> encounter) async {
    final enriched = Map<String, dynamic>.from(encounter);

    try {
      // Resolve patient reference
      final patientRef = encounter['subject']?['reference'] as String?;
      if (patientRef != null) {
        final patient = await _datasource.resolveReference(patientRef);
        if (patient != null) {
          enriched['_resolved_patient'] = patient;
        }
      }

      // Resolve practitioner references
      final participants = encounter['participant'] as List<dynamic>?;
      if (participants != null) {
        final resolvedPractitioners = <Map<String, dynamic>>[];

        for (final participant in participants) {
          if (participant is Map<String, dynamic>) {
            final practitionerRef =
                participant['individual']?['reference'] as String?;
            if (practitionerRef != null) {
              final practitioner =
                  await _datasource.resolveReference(practitionerRef);
              if (practitioner != null) {
                resolvedPractitioners.add(practitioner);
              }
            }
          }
        }

        if (resolvedPractitioners.isNotEmpty) {
          enriched['_resolved_practitioners'] = resolvedPractitioners;
        }
      }

      // Resolve service provider (organization)
      final serviceProviderRef =
          encounter['serviceProvider']?['reference'] as String?;
      if (serviceProviderRef != null) {
        final organization =
            await _datasource.resolveReference(serviceProviderRef);
        if (organization != null) {
          enriched['_resolved_organization'] = organization;
        }
      }

      // Resolve location references
      final locations = encounter['location'] as List<dynamic>?;
      if (locations != null) {
        final resolvedLocations = <Map<String, dynamic>>[];

        for (final location in locations) {
          if (location is Map<String, dynamic>) {
            final locationRef = location['location']?['reference'] as String?;
            if (locationRef != null) {
              final resolvedLocation =
                  await _datasource.resolveReference(locationRef);
              if (resolvedLocation != null) {
                resolvedLocations.add(resolvedLocation);
              }
            }
          }
        }

        if (resolvedLocations.isNotEmpty) {
          enriched['_resolved_locations'] = resolvedLocations;
        }
      }
    } catch (e, stack) {
      logger.e('RecordsRepository: Error enriching encounter', e, stack);
    }

    return enriched;
  }

  /// Build encounter display model from enriched data
  EncounterDisplayModel _buildEncounterDisplayModel(
      Map<String, dynamic> encounter) {
    final id = encounter['id'] as String? ?? '';

    // Extract encounter type from the type field (like backup version)
    String encounterType = 'Encounter';
    final type = encounter['type'] as List<dynamic>?;
    if (type != null && type.isNotEmpty) {
      final firstType = type.first as Map<String, dynamic>;
      final text = firstType['text'] as String?;
      if (text != null && text.isNotEmpty) {
        encounterType = text;
      } else {
        final coding = firstType['coding'] as List<dynamic>?;
        if (coding != null && coding.isNotEmpty) {
          final firstCoding = coding.first as Map<String, dynamic>;
          final display = firstCoding['display'] as String?;
          if (display != null && display.isNotEmpty) {
            encounterType = display;
          }
        }
      }
    } else {
      // Fallback to class display
      final classDisplay = encounter['class']?['display'] as String?;
      if (classDisplay != null) {
        encounterType = classDisplay;
      }
    }

    // Extract date
    final period = encounter['period'] as Map<String, dynamic>?;
    final startDate = period?['start'] as String?;
    final endDate = period?['end'] as String?;

    // Extract location
    final locations = encounter['location'] as List<dynamic>?;
    final resolvedLocations =
        encounter['_resolved_locations'] as List<dynamic>?;

    final locationNames = <String>[];
    if (resolvedLocations != null) {
      for (final location in resolvedLocations) {
        if (location is Map<String, dynamic>) {
          final name = location['name'] as String? ?? 'Unknown Location';
          locationNames.add(name);
        }
      }
    } else if (locations != null) {
      for (final location in locations) {
        if (location is Map<String, dynamic>) {
          final display =
              location['location']?['display'] as String? ?? 'Unknown Location';
          locationNames.add(display);
        }
      }
    }

    // Extract patient info
    final resolvedPatient =
        encounter['_resolved_patient'] as Map<String, dynamic>?;
    final patientDisplay = resolvedPatient != null
        ? _extractPatientName(resolvedPatient) ?? 'Unknown Patient'
        : 'Unknown Patient';

    // Extract practitioner info
    final resolvedPractitioners =
        encounter['_resolved_practitioners'] as List<dynamic>?;
    final practitionerNames = <String>[];
    if (resolvedPractitioners != null) {
      for (final practitioner in resolvedPractitioners) {
        if (practitioner is Map<String, dynamic>) {
          final name = _extractPractitionerName(practitioner);
          if (name != null) {
            practitionerNames.add(name);
          }
        }
      }
    }

    // Extract organization info
    final resolvedOrganization =
        encounter['_resolved_organization'] as Map<String, dynamic>?;
    final organizationName = resolvedOrganization?['name'] as String? ?? '';

    return EncounterDisplayModel(
      id: id,
      patientDisplay: patientDisplay,
      encounterType: encounterType, // Now using the proper encounter type
      startDate: startDate,
      endDate: endDate,
      practitionerNames: practitionerNames,
      organizationName: organizationName,
      locationNames: locationNames,
      rawEncounter: encounter,
    );
  }

  /// Extract patient name from patient resource
  String? _extractPatientName(Map<String, dynamic> patient) {
    final name = patient['name'] as List<dynamic>?;
    if (name?.isNotEmpty == true) {
      final firstName = name!.first;
      if (firstName is Map<String, dynamic>) {
        final given = firstName['given'] as List<dynamic>?;
        final family = firstName['family'] as String?;

        final givenNames = given?.cast<String>().join(' ') ?? '';
        return '$givenNames $family'.trim();
      }
    }
    return null;
  }

  /// Extract practitioner name from practitioner resource
  String? _extractPractitionerName(Map<String, dynamic> practitioner) {
    final name = practitioner['name'] as List<dynamic>?;
    if (name?.isNotEmpty == true) {
      final firstName = name!.first;
      if (firstName is Map<String, dynamic>) {
        final given = firstName['given'] as List<dynamic>?;
        final family = firstName['family'] as String?;
        final prefix = firstName['prefix'] as List<dynamic>?;

        final prefixStr = prefix?.isNotEmpty == true ? '${prefix!.first} ' : '';
        final givenNames = given?.cast<String>().join(' ') ?? '';
        return '$prefixStr$givenNames $family'.trim();
      }
    }
    return null;
  }

  /// Extract date from resource using factory pattern
  String? _extractResourceDate(Map<String, dynamic> resource) {
    final resourceType = resource['resourceType'] as String?;

    if (resourceType == 'AllergyIntolerance') {
      // For AllergyIntolerance, try multiple date fields (like backup version)
      return resource['onsetDateTime'] as String? ??
          resource['recordedDate'] as String? ??
          resource['assertedDate'] as String?;
    }

    // Try different date fields based on resource type
    return resource['effectiveDateTime'] as String? ??
        resource['onsetDateTime'] as String? ??
        resource['recordedDate'] as String? ??
        resource['authoredOn'] as String? ??
        resource['performedDateTime'] as String? ??
        resource['issued'] as String? ??
        resource['date'] as String? ??
        resource['created'] as String? ??
        resource['period']?['start'] as String?;
  }

  /// Check if a resource references any encounter
  bool _referencesAnyEncounter(Map<String, dynamic> resource) {
    // Check encounter field
    final encounterField = resource['encounter'];
    if (encounterField != null) {
      if (encounterField is Map<String, dynamic>) {
        return encounterField['reference'] != null;
      } else if (encounterField is List && encounterField.isNotEmpty) {
        return true;
      }
    }

    // Check context field
    final contextRef = resource['context'] as Map<String, dynamic>?;
    if (contextRef != null) {
      final reference = contextRef['reference'] as String?;
      if (reference?.startsWith('Encounter/') == true) {
        return true;
      }
    }

    return false;
  }

  /// Check if resource references encounter
  bool _referencesEncounter(Map<String, dynamic> resource, String encounterId) {
    // Check encounter field
    final encounterField = resource['encounter'];
    if (encounterField != null) {
      if (encounterField is Map<String, dynamic>) {
        final reference = encounterField['reference'] as String?;
        return reference == 'Encounter/$encounterId' ||
            reference == 'urn:uuid:$encounterId';
      } else if (encounterField is List) {
        for (final encounterRef in encounterField) {
          if (encounterRef is Map<String, dynamic>) {
            final reference = encounterRef['reference'] as String?;
            if (reference == 'Encounter/$encounterId' ||
                reference == 'urn:uuid:$encounterId') {
              return true;
            }
          }
        }
      }
    }

    // Check context field
    final contextRef = resource['context'] as Map<String, dynamic>?;
    if (contextRef != null) {
      final reference = contextRef['reference'] as String?;
      return reference == 'Encounter/$encounterId' ||
          reference == 'urn:uuid:$encounterId';
    }

    return false;
  }

  /// Check if a resource is referenced by a specific encounter (reverse relationship)
  bool _isReferencedByEncounter(
      Map<String, dynamic> resource, Map<String, dynamic> encounter) {
    final resourceId = resource['id'] as String?;
    if (resourceId == null) return false;

    // Helper function to check if a reference matches this resource
    bool checkReference(String? reference) {
      if (reference == null) return false;

      // Handle different reference formats:
      // 1. "ResourceType/id" format
      // 2. "urn:uuid:id" format
      final resourceType = resource['resourceType'] as String?;
      return reference == '$resourceType/$resourceId' ||
          reference == 'urn:uuid:$resourceId' ||
          (reference.startsWith('urn:uuid:') &&
              reference.substring(9) == resourceId);
    }

    // Check patient reference (subject field)
    final subjectRef = encounter['subject'] as Map<String, dynamic>?;
    if (subjectRef != null) {
      final reference = subjectRef['reference'] as String?;
      if (checkReference(reference)) return true;
    }

    // Check practitioner references (participant field)
    final participants = encounter['participant'] as List<dynamic>?;
    if (participants != null) {
      for (final participant in participants) {
        if (participant is Map<String, dynamic>) {
          final individualRef =
              participant['individual'] as Map<String, dynamic>?;
          if (individualRef != null) {
            final reference = individualRef['reference'] as String?;
            if (checkReference(reference)) return true;
          }
        }
      }
    }

    // Check organization reference (serviceProvider field)
    final serviceProviderRef =
        encounter['serviceProvider'] as Map<String, dynamic>?;
    if (serviceProviderRef != null) {
      final reference = serviceProviderRef['reference'] as String?;
      if (checkReference(reference)) return true;
    }

    // Check location references (location field)
    final locations = encounter['location'] as List<dynamic>?;
    if (locations != null) {
      for (final location in locations) {
        if (location is Map<String, dynamic>) {
          final locationRef = location['location'] as Map<String, dynamic>?;
          if (locationRef != null) {
            final reference = locationRef['reference'] as String?;
            if (checkReference(reference)) return true;
          }
        }
      }
    }

    // Check reasonReference field (can reference various resource types)
    final reasonReferences = encounter['reasonReference'] as List<dynamic>?;
    if (reasonReferences != null) {
      for (final reasonRef in reasonReferences) {
        if (reasonRef is Map<String, dynamic>) {
          final reference = reasonRef['reference'] as String?;
          if (checkReference(reference)) return true;
        }
      }
    }

    // Check diagnosis references
    final diagnosis = encounter['diagnosis'] as List<dynamic>?;
    if (diagnosis != null) {
      for (final diag in diagnosis) {
        if (diag is Map<String, dynamic>) {
          final condition = diag['condition'] as Map<String, dynamic>?;
          if (condition != null) {
            final reference = condition['reference'] as String?;
            if (checkReference(reference)) return true;
          }
        }
      }
    }

    // Check hospitalization references
    final hospitalization =
        encounter['hospitalization'] as Map<String, dynamic>?;
    if (hospitalization != null) {
      final origin = hospitalization['origin'] as Map<String, dynamic>?;
      if (origin != null) {
        final reference = origin['reference'] as String?;
        if (checkReference(reference)) return true;
      }

      final destination =
          hospitalization['destination'] as Map<String, dynamic>?;
      if (destination != null) {
        final reference = destination['reference'] as String?;
        if (checkReference(reference)) return true;
      }
    }

    return false;
  }

  /// Parse FHIR Bundle resources with individual source IDs
  Map<String, List<Map<String, dynamic>>> _parseBundleResourcesWithSourceIds(
      String bundleJson) {
    final resourcesWithSourceIds = <String, List<Map<String, dynamic>>>{};
    final sourceIdStats = <String, int>{};

    try {
      final bundle = json.decode(bundleJson) as Map<String, dynamic>;

      final entries = bundle['entry'] as List<dynamic>?;
      if (entries != null) {
        logger.d('Found ${entries.length} entries in bundle');
        for (final entry in entries) {
          if (entry is Map<String, dynamic>) {
            final resourceWrapper = entry['resource'] as Map<String, dynamic>?;
            if (resourceWrapper != null) {
              // Support both wrapped and direct resource
              final resource =
                  resourceWrapper['resource_raw'] as Map<String, dynamic>? ??
                      resourceWrapper;
              // Try to extract source_id from resource or wrapper
              final resourceSourceId = resource['source_id'] as String? ??
                  resourceWrapper['source_id'] as String?;

              if (resource != null) {
                final resourceType = resource['resourceType'] as String?;
                if (resourceType != null) {
                  resourcesWithSourceIds.putIfAbsent(resourceType, () => []);

                  // Add the individual source ID to the resource data
                  final resourceWithSourceId =
                      Map<String, dynamic>.from(resource);
                  resourceWithSourceId['_sourceId'] = resourceSourceId;

                  resourcesWithSourceIds[resourceType]!
                      .add(resourceWithSourceId);

                  // Track source ID statistics
                  if (resourceSourceId != null) {
                    sourceIdStats[resourceSourceId] =
                        (sourceIdStats[resourceSourceId] ?? 0) + 1;
                  }
                }
              }
            }
          }
        }
        logger.d(
            'Parsed ${resourcesWithSourceIds.length} resource types from bundle');
        logger.d('Source ID distribution: ${sourceIdStats}');
      }
    } catch (e) {
      logger.e('Error parsing bundle: ${e}');
    }

    return resourcesWithSourceIds;
  }

  /// Check if cache is valid
  bool _isCacheValid(String key) {
    if (!_cacheTimestamps.containsKey(key)) return false;
    final timestamp = _cacheTimestamps[key]!;
    return DateTime.now().difference(timestamp) < _cacheExpiry;
  }

  /// Clear all caches
  void _clearAllCaches() {
    _timelineCache.clear();
    _encounterRelatedCache.clear();
    _cacheTimestamps.clear();
  }

  /// Clear specific cache
  void clearCache(String key) {
    _timelineCache.remove(key);
    _encounterRelatedCache.remove(key);
    _cacheTimestamps.remove(key);
  }


  // TODO: improve upon this and refactor/remove the above functions
  @override
  Future<List<IFhirResource>> getResources({
    List<FhirType> resourceTypes = const [],
    String? sourceId,
    int? limit,
    int? offset,
  }) async {
    if (resourceTypes.isEmpty) {
      resourceTypes = FhirType.values;
    }
    List<FhirResourceLocalDto> resourceData = await _datasource.getResources(
      resourceTypes: resourceTypes.map((type) => type.display).toList(),
      sourceId: sourceId,
      limit: limit,
      offset: offset,
    );

    return resourceData
        .map((data) => _mapper.mapResourceFromLocalData(data))
        .toList();
  }
}
