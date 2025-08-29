import 'package:health_wallet/features/sync/domain/services/demo_data_extractor.dart';
import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/sync/data/dto/fhir_resource_dto.dart';
import 'package:health_wallet/features/sync/data/data_source/local/fhir_local_data_source.dart';
import 'package:health_wallet/core/utils/logger.dart';

/// Handles common resource processing operations for sync services
@injectable
class ResourceProcessor {
  final FhirLocalDataSource _fhirLocalDataSource;

  ResourceProcessor(this._fhirLocalDataSource);

  /// Processes a list of raw resources and converts them to FhirResourceDto
  List<FhirResourceDto> processRawResources(
    List<dynamic> rawResources,
    String changeType,
  ) {
    try {
      logger.d(
          '🔄 Processing ${rawResources.length} resources with change type: $changeType');

      final processedResources = <FhirResourceDto>[];

      for (final resource in rawResources) {
        try {
          if (resource is Map<String, dynamic>) {
            // Inject change_type into the resource map
            final resourceMap = Map<String, dynamic>.from(resource);
            resourceMap['change_type'] = changeType;

            final fhirResource = FhirResourceDto.fromJson(resourceMap);

            // Extract encounter and subject references from the raw resource (same as demo data)
            final populatedResource = fhirResource
                .populateEncounterIdFromRaw()
                .populateSubjectIdFromRaw();

            processedResources.add(populatedResource);
          } else {
            logger.w(
                '⚠️ Skipping invalid resource format: ${resource.runtimeType}');
          }
        } catch (e) {
          logger.e('❌ Failed to process resource: $e');
          // Continue processing other resources
        }
      }

      logger.d(
          '✅ Successfully processed ${processedResources.length}/${rawResources.length} resources');
      return processedResources;
    } catch (e) {
      logger.e('❌ Resource processing failed: $e');
      rethrow;
    }
  }

  /// Merges resources into the local database
  Future<void> mergeResources({
    required List<FhirResourceDto> created,
    required List<FhirResourceDto> updated,
    required List<FhirResourceDto> deleted,
  }) async {
    try {
      logger.d(
          '🔄 Merging resources: ${created.length} created, ${updated.length} updated, ${deleted.length} deleted');

      // Handle created and updated resources
      final allResources = [...created, ...updated];
      if (allResources.isNotEmpty) {
        await _fhirLocalDataSource.cacheFhirResources(allResources);
        logger.d('✅ Cached ${allResources.length} resources');
      }

      // Handle deleted resources
      if (deleted.isNotEmpty) {
        await _fhirLocalDataSource.markResourcesAsDeleted(deleted);
        logger.d('✅ Marked ${deleted.length} resources as deleted');
      }

      logger.d('✅ Resource merge completed successfully');
    } catch (e) {
      logger.e('❌ Resource merge failed: $e');
      rethrow;
    }
  }

  /// Validates resource data before processing
  bool validateResource(Map<String, dynamic> resource) {
    try {
      // Check for required fields
      final requiredFields = ['resource_type', 'source_resource_id'];
      for (final field in requiredFields) {
        if (!resource.containsKey(field) || resource[field] == null) {
          logger.w('⚠️ Resource missing required field: $field');
          return false;
        }
      }

      // Check resource type format
      final resourceType = resource['resource_type'] as String?;
      if (resourceType == null || resourceType.isEmpty) {
        logger.w('⚠️ Invalid resource type: $resourceType');
        return false;
      }

      // Check source resource ID format
      final sourceId = resource['source_resource_id'] as String?;
      if (sourceId == null || sourceId.isEmpty) {
        logger.w('⚠️ Invalid source resource ID: $sourceId');
        return false;
      }

      return true;
    } catch (e) {
      logger.e('❌ Resource validation failed: $e');
      return false;
    }
  }

  /// Filters resources by change type
  Map<String, List<FhirResourceDto>> groupResourcesByChangeType(
      List<FhirResourceDto> resources) {
    final grouped = <String, List<FhirResourceDto>>{
      'created': [],
      'updated': [],
      'deleted': [],
    };

    for (final resource in resources) {
      if (resource.isCreated) {
        grouped['created']!.add(resource);
      } else if (resource.isUpdated) {
        grouped['updated']!.add(resource);
      } else if (resource.isDeleted) {
        grouped['deleted']!.add(resource);
      }
    }

    return grouped;
  }

  /// Gets resource statistics for logging and monitoring
  Map<String, int> getResourceStats(List<FhirResourceDto> resources) {
    final stats = <String, int>{
      'total': resources.length,
      'created': 0,
      'updated': 0,
      'deleted': 0,
    };

    for (final resource in resources) {
      if (resource.isCreated) {
        stats['created'] = (stats['created'] ?? 0) + 1;
      } else if (resource.isUpdated) {
        stats['updated'] = (stats['updated'] ?? 0) + 1;
      } else if (resource.isDeleted) {
        stats['deleted'] = (stats['deleted'] ?? 0) + 1;
      }
    }

    return stats;
  }

  /// Logs resource processing summary
  void logResourceSummary(Map<String, int> stats) {
    logger.i('📊 Resource Processing Summary:');
    logger.i('   Total: ${stats['total']}');
    logger.i('   Created: ${stats['created']}');
    logger.i('   Updated: ${stats['updated']}');
    logger.i('   Deleted: ${stats['deleted']}');
  }

  List<FhirResourceDto> processDemoResources(
    List<dynamic> rawResources, {
    String? sourceId,
  }) {
    try {
      logger.d('🧪 Processing ${rawResources.length} demo resources');

      // Use provided sourceId or default to 'demo_data'
      final demoSourceId = sourceId ?? 'demo_data';

      final processedResources = <FhirResourceDto>[];

      for (final resource in rawResources) {
        try {
          if (resource is Map<String, dynamic>) {
            // Map FHIR resource fields to FhirResourceDto fields (same as sync data)
            final resourceMap = <String, dynamic>{
              'id': resource['id'],
              'source_id': demoSourceId,
              'source_resource_type': resource['resourceType'],
              'source_resource_id': resource['id'],
              'sort_title': DemoDataExtractor.extractTitle(resource),
              'sort_date': DemoDataExtractor.extractDate(resource),
              'resource_raw': resource,
              'change_type': 'created',
            };

            // Use the same processing as sync data
            final fhirResource = FhirResourceDto.fromJson(resourceMap);

            // Extract encounter and subject references from the raw resource (same as demo data)
            final populatedResource = fhirResource
                .populateEncounterIdFromRaw()
                .populateSubjectIdFromRaw();

            processedResources.add(populatedResource);
          } else {
            logger.w(
                '⚠️ Skipping invalid demo resource format: ${resource.runtimeType}');
          }
        } catch (e) {
          logger.e('❌ Failed to process demo resource: $e');
          // Continue processing other resources
        }
      }

      logger.d(
          '✅ Successfully processed ${processedResources.length}/${rawResources.length} demo resources');
      return processedResources;
    } catch (e) {
      logger.e('❌ Demo data processing failed: $e');
      rethrow;
    }
  }

  /// Gets demo resource statistics for logging and monitoring
  Map<String, int> getDemoResourceStats(List<FhirResourceDto> resources) {
    final stats = <String, int>{
      'total': resources.length,
      'patients': 0,
      'observations': 0,
      'encounters': 0,
      'other': 0,
    };

    for (final resource in resources) {
      switch (resource.resourceType) {
        case 'Patient':
          stats['patients'] = (stats['patients'] ?? 0) + 1;
          break;
        case 'Observation':
          stats['observations'] = (stats['observations'] ?? 0) + 1;
          break;
        case 'Encounter':
          stats['encounters'] = (stats['encounters'] ?? 0) + 1;
          break;
        default:
          stats['other'] = (stats['other'] ?? 0) + 1;
      }
    }

    return stats;
  }

  /// Logs demo resource processing summary
  void logDemoResourceSummary(Map<String, int> stats) {
    logger.i('📊 Demo Resource Processing Summary:');
    logger.i('   Total: ${stats['total']}');
    logger.i('   Patients: ${stats['patients']}');
    logger.i('   Observations: ${stats['observations']}');
    logger.i('   Encounters: ${stats['encounters']}');
    logger.i('   Other: ${stats['other']}');
  }
}
