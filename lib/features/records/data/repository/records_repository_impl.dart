import 'dart:convert';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/records/data/datasource/fhir_resource_datasource.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/features/records/domain/utils/encounter_relation_checker.dart';
import 'package:health_wallet/features/records/presentation/models/fhir_resource_display_model.dart';
import 'package:health_wallet/features/records/domain/factory/display_factory_manager.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:injectable/injectable.dart';

@Injectable(as: RecordsRepository)
class RecordsRepositoryImpl implements RecordsRepository {
  final FhirResourceDatasource _datasource;

  // Simple cache for encounter-related resources
  final Map<String, Map<String, List<FhirResourceDisplayModel>>>
      _encounterRelatedCache = {};

  RecordsRepositoryImpl(AppDatabase database)
      : _datasource = FhirResourceDatasource(database);

  @override
  void reset() {
    _encounterRelatedCache.clear();
  }

  @override
  bool get hasMorePages => true; // Simplified - always return true for now

  /// Create entity from raw data using direct entity creation
  IFhirResource createEntityFromMap(Map<String, dynamic> data) {
    final resourceType = data['resourceType'] as String? ?? 'Unknown';

    // Create DTO for entity creation
    final dto = FhirResourceLocalDto(
      id: data['id'] as String? ?? '',
      resourceType: resourceType,
      resourceRaw: jsonEncode(data),
      sourceId: data['sourceId'] as String? ?? '',
      resourceId: data['resourceId'] as String? ?? '',
      title: data['title'] as String? ?? '',
      date: null, // Let entities handle their own date extraction
    );

    // Use entity's built-in FHIR R4 parsing
    switch (resourceType) {
      case 'Patient':
        return Patient.fromLocalData(dto);
      case 'Observation':
        return Observation.fromLocalData(dto);
      case 'Encounter':
        return Encounter.fromLocalData(dto);
      case 'Condition':
        return Condition.fromLocalData(dto);
      case 'AllergyIntolerance':
        return AllergyIntolerance.fromLocalData(dto);
      case 'Medication':
        return Medication.fromLocalData(dto);
      case 'MedicationRequest':
        return MedicationRequest.fromLocalData(dto);
      case 'MedicationStatement':
        return MedicationStatement.fromLocalData(dto);
      case 'MedicationAdministration':
        return MedicationAdministration.fromLocalData(dto);
      case 'MedicationDispense':
        return MedicationDispense.fromLocalData(dto);
      case 'Procedure':
        return Procedure.fromLocalData(dto);
      case 'DiagnosticReport':
        return DiagnosticReport.fromLocalData(dto);
      case 'DocumentReference':
        return DocumentReference.fromLocalData(dto);
      case 'Immunization':
        return Immunization.fromLocalData(dto);
      case 'CareTeam':
        return CareTeam.fromLocalData(dto);
      case 'Goal':
        return Goal.fromLocalData(dto);
      case 'Location':
        return Location.fromLocalData(dto);
      case 'Organization':
        return Organization.fromLocalData(dto);
      case 'Practitioner':
        return Practitioner.fromLocalData(dto);
      case 'PractitionerRole':
        return PractitionerRole.fromLocalData(dto);
      case 'RelatedPerson':
        return RelatedPerson.fromLocalData(dto);
      case 'ServiceRequest':
        return ServiceRequest.fromLocalData(dto);
      case 'Specimen':
        return Specimen.fromLocalData(dto);
      case 'Binary':
        return Binary.fromLocalData(dto);
      case 'Media':
        return Media.fromLocalData(dto);
      case 'AdverseEvent':
        return AdverseEvent.fromLocalData(dto);
      case 'Claim':
        return Claim.fromLocalData(dto);
      case 'ExplanationOfBenefit':
        return ExplanationOfBenefit.fromLocalData(dto);
      case 'Coverage':
        return Coverage.fromLocalData(dto);
      default:
        return GeneralResource(
          id: dto.id,
          sourceId: dto.sourceId ?? '',
          resourceId: dto.resourceId ?? '',
          title: dto.title ?? '',
          date: dto.date,
        );
    }
  }

  /// Get resources for timeline display (encounters and standalone resources)
  @override
  Future<List<IFhirResource>> getResources({
    List<FhirType> resourceTypes = const [],
    String? sourceId,
    int? limit,
    int? offset,
  }) async {
    final actualLimit = limit ?? 20;
    final actualOffset = offset ?? 0;

    try {
      final rawResources = await _datasource.getAllResources(
        'all',
        limit: actualLimit,
        offset: actualOffset,
        sourceId: sourceId,
      );

      final allEntities =
          rawResources.map((data) => createEntityFromMap(data)).toList();

      List<IFhirResource> filteredEntities = allEntities;
      if (resourceTypes.isNotEmpty) {
        filteredEntities = allEntities
            .where((entity) => resourceTypes.contains(entity.fhirType))
            .toList();
      }

      if (sourceId != null) {
        filteredEntities = filteredEntities
            .where((entity) => entity.sourceId == sourceId)
            .toList();
      }

      final timelineResources = filteredEntities.where((entity) {
        final shouldDisplay =
            EncounterRelationChecker.shouldDisplayInTimeline(entity);
        return shouldDisplay;
      }).toList();

      timelineResources.sort((a, b) {
        if (a.date == null && b.date == null) return 0;
        if (a.date == null) return 1;
        if (b.date == null) return -1;
        return b.date!.compareTo(a.date!);
      });

      final paginatedResources =
          timelineResources.skip(actualOffset).take(actualLimit).toList();

      return paginatedResources;
    } catch (e, stack) {
      logger.e('RecordsRepository: Error getting resources', e, stack);
      rethrow;
    }
  }

  /// Get all resources (for home page filtering)
  @override
  Future<List<IFhirResource>> getAllResources({
    List<FhirType> resourceTypes = const [],
    String? sourceId,
    int? limit,
    int? offset,
  }) async {
    final actualLimit = limit ?? 20;
    final actualOffset = offset ?? 0;

    try {
      // If we have specific resource types, query for the first one specifically
      // This ensures we get the right resources from the database
      final resourceTypeToQuery = resourceTypes.isNotEmpty
          ? resourceTypes.first.toString().split('.').last
          : 'all';

      final rawResources = await _datasource.getAllResources(
        resourceTypeToQuery,
        limit: actualLimit,
        offset: actualOffset,
        sourceId: sourceId,
      );

      final allEntities =
          rawResources.map((data) => createEntityFromMap(data)).toList();

      List<IFhirResource> filteredEntities = allEntities;
      if (resourceTypes.isNotEmpty) {
        filteredEntities = allEntities
            .where((entity) => resourceTypes.contains(entity.fhirType))
            .toList();
      }

      if (sourceId != null) {
        filteredEntities = filteredEntities
            .where((entity) => entity.sourceId == sourceId)
            .toList();
      }

      filteredEntities.sort((a, b) {
        if (a.date == null && b.date == null) return 0;
        if (a.date == null) return 1;
        if (b.date == null) return -1;
        return b.date!.compareTo(a.date!);
      });

      final paginatedResources =
          filteredEntities.skip(actualOffset).take(actualLimit).toList();

      return paginatedResources;
    } catch (e, stack) {
      logger.e('RecordsRepository: Error getting ALL resources', e, stack);
      rethrow;
    }
  }

  /// Get related resources for an encounter
  @override
  Future<Map<String, List<FhirResourceDisplayModel>>>
      getRelatedResourcesForEncounter(String encounterId) async {
    // Check cache first
    if (_encounterRelatedCache.containsKey(encounterId)) {
      return _encounterRelatedCache[encounterId]!;
    }

    try {
      // Get all resources and filter for encounter-related ones
      final allResources = await _datasource.getAllResources('all');
      final relatedResources = allResources.where((resource) {
        final resourceType = resource['resourceType'] as String?;
        final encounterRef = resource['encounter']?['reference'] as String?;
        return encounterRef?.contains(encounterId) == true;
      }).toList();

      // Convert to display models
      final displayModels = <String, List<FhirResourceDisplayModel>>{};

      for (final resource in relatedResources) {
        final entity = createEntityFromMap(resource);
        final displayModel = _buildDisplayModel(entity);

        final resourceType = entity.fhirType.display;
        displayModels[resourceType] = displayModels[resourceType] ?? [];
        displayModels[resourceType]!.add(displayModel);
      }

      // Cache the result
      _encounterRelatedCache[encounterId] = displayModels;

      return displayModels;
    } catch (e, stack) {
      logger.e('RecordsRepository: Error getting related resources', e, stack);
      rethrow;
    }
  }

  /// Build display model from entity using factory
  FhirResourceDisplayModel _buildDisplayModel(IFhirResource entity) {
    // Import the factory manager only for display model creation
    final factoryManager = DisplayFactoryManager.instance;
    return factoryManager.buildDisplayModel(entity);
  }

  @override
  Future<Map<String, dynamic>?> resolveReference(String reference) async {
    return await _datasource.resolveReference(reference);
  }

  @override
  Future<String?> getReferenceDisplayName(String reference) async {
    return null;
  }
}
