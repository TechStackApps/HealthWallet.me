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
      logger.d('🔄 Processing ${rawResources.length} resources with change type: $changeType');
      
      final processedResources = <FhirResourceDto>[];
      
      for (final resource in rawResources) {
        try {
          if (resource is Map<String, dynamic>) {
            // Inject change_type into the resource map
            final resourceMap = Map<String, dynamic>.from(resource);
            resourceMap['change_type'] = changeType;
            
            final fhirResource = FhirResourceDto.fromJson(resourceMap);
            processedResources.add(fhirResource);
          } else {
            logger.w('⚠️ Skipping invalid resource format: ${resource.runtimeType}');
          }
        } catch (e) {
          logger.e('❌ Failed to process resource: $e');
          // Continue processing other resources
        }
      }
      
      logger.d('✅ Successfully processed ${processedResources.length}/${rawResources.length} resources');
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
      logger.d('🔄 Merging resources: ${created.length} created, ${updated.length} updated, ${deleted.length} deleted');
      
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
  Map<String, List<FhirResourceDto>> groupResourcesByChangeType(List<FhirResourceDto> resources) {
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
}
