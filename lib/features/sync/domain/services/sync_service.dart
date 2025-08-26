import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/sync/data/data_source/remote/remote_sync_service.dart';
import 'package:health_wallet/features/sync/data/data_source/local/fhir_local_data_source.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_token.dart';
import 'package:health_wallet/features/sync/data/dto/fhir_resource_dto.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_job.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_progress.dart';
import 'package:health_wallet/features/sync/domain/services/resource_processor.dart';
import 'package:health_wallet/features/sync/domain/services/sync_retry_service.dart';
import 'package:health_wallet/features/sync/domain/services/sync_error_handler.dart';

@injectable
class SyncService {
  final RemoteSyncService _remoteService;
  final FhirLocalDataSource _fhirLocalDataSource;
  final SharedPreferences _prefs;
  final ResourceProcessor _resourceProcessor;
  final SyncRetryService _retryService;
  final SyncErrorHandler _errorHandler;

  static const String _syncJobKey = 'background_sync_job';
  static const String _syncProgressKey = 'background_sync_progress';
  static const String _lastFullSyncKey = 'last_full_sync_timestamp';

  SyncService(
    this._remoteService,
    this._fhirLocalDataSource,
    this._prefs,
    this._resourceProcessor,
    this._retryService,
    this._errorHandler,
  );

  // ===== BACKGROUND SYNC METHODS =====

  /// Start a background sync job
  Future<void> startBackgroundSync(SyncToken token,
      {required String baseUrl}) async {
    try {
      logger.d('🚀 Starting background sync job...');

      // Check if there's already a sync in progress
      final existingJob = await _getCurrentSyncJob();
      if (existingJob != null && existingJob.status == SyncJobStatus.running) {
        logger.w('⚠️ Sync job already in progress, skipping');
        return;
      }

      // Create new sync job
      final syncJob = SyncJob(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        status: SyncJobStatus.running,
        startTime: DateTime.now(),
        token: token,
        totalResourceTypes: 0,
        completedResourceTypes: 0,
      );

      await _saveSyncJob(syncJob);

      // Start the sync process with the working base URL
      await _runBackgroundSync(syncJob, baseUrl: baseUrl);
    } catch (e, s) {
      logger.e('❌ Failed to start background sync: $e', e, s);
      await _updateSyncJobStatus(SyncJobStatus.failed, error: e.toString());
      rethrow;
    }
  }

  /// Start a smart sync job that chooses between full and incremental
  Future<void> startSmartSync(SyncToken token, {required String baseUrl}) async {
    try {
      logger.d('🧠 Starting smart sync job...');

      // Check if there's already a sync in progress
      final existingJob = await _getCurrentSyncJob();
      if (existingJob != null && existingJob.status == SyncJobStatus.running) {
        logger.w('⚠️ Sync job already in progress, skipping');
        return;
      }

      // Create new sync job
      final syncJob = SyncJob(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        status: SyncJobStatus.running,
        startTime: DateTime.now(),
        token: token,
        totalResourceTypes: 0,
        completedResourceTypes: 0,
      );

      await _saveSyncJob(syncJob);

      // Start the smart sync process with the working base URL
      await _runSmartSync(syncJob, baseUrl: baseUrl);
    } catch (e, s) {
      logger.e('❌ Failed to start smart sync: $e', e, s);
      await _updateSyncJobStatus(SyncJobStatus.failed, error: e.toString());
      rethrow;
    }
  }

  // ===== INCREMENTAL SYNC METHODS =====

  /// Perform incremental sync since the last sync timestamp
  Future<IncrementalSyncResult> syncUpdates({
    required SyncToken token,
    required String baseUrl,
    required String since,
    String? resourceType,
    int limit = 1000,
  }) async {
    return _retryService.executeWithRetry(
      'incremental_sync',
      () async {
        try {
          // Validate token and base URL
          await _validateToken(token);
          await _validateWorkingBaseUrl(baseUrl);

          logSyncStart('Incremental sync', {
            'since': since,
            'resourceType': resourceType,
            'limit': limit,
          });

          final response = await _remoteService.getIncrementalUpdates(
            baseUrl: baseUrl,
            token: token.token,
            since: since,
            resourceType: resourceType,
            limit: limit,
          );

          if (response['success'] == true && response['data'] != null) {
            final data = response['data'] as Map<String, dynamic>;

            // Process resources using ResourceProcessor
            final created = _resourceProcessor.processRawResources(
                data['created'] ?? [], 'created');
            final updated = _resourceProcessor.processRawResources(
                data['updated'] ?? [], 'updated');
            final deleted = _resourceProcessor.processRawResources(
                data['deleted'] ?? [], 'deleted');

            // Merge with local database using ResourceProcessor
            await _resourceProcessor.mergeResources(
              created: created,
              updated: updated,
              deleted: deleted,
            );

            // Update last sync timestamp
            await _updateLastSyncTimestamp(DateTime.now().toIso8601String());

            final result = IncrementalSyncResult(
              created: created.length,
              updated: updated.length,
              deleted: deleted.length,
              hasMore: data['hasMore'] ?? false,
              nextOffset: data['pagination']?['nextOffset'] ?? 0,
            );

            logSyncComplete('Incremental sync', {
              'created': created.length,
              'updated': updated.length,
              'deleted': deleted.length,
              'hasMore': result.hasMore,
            });

            return result;
          } else {
            throw Exception('Invalid response from incremental sync endpoint');
          }
        } catch (e, s) {
          // Handle and standardize the error
          final syncException = _errorHandler.handleError(
            e,
            operation: 'incremental_sync',
            context: {
              'since': since,
              'resourceType': resourceType,
              'limit': limit,
            },
          );
          throw syncException;
        }
      },
    );
  }

  // ===== BASE SYNC METHODS =====

  /// Validate token
  Future<void> _validateToken(SyncToken token) async {
    if (!token.isValid) {
      throw Exception('Token is invalid or expired');
    }
  }

  /// Validate working base URL
  Future<void> _validateWorkingBaseUrl(String baseUrl) async {
    if (baseUrl.isEmpty) {
      throw Exception('Working base URL is required');
    }
  }

  /// Update last sync timestamp
  Future<void> _updateLastSyncTimestamp(String timestamp) async {
    await _prefs.setString(_lastFullSyncKey, timestamp);
  }

  /// Log sync start
  void logSyncStart(String operation, Map<String, dynamic> context) {
    logger.d('🔄 Starting $operation: $context');
  }

  /// Log sync complete
  void logSyncComplete(String operation, Map<String, dynamic> context) {
    logger.d('✅ Completed $operation: $context');
  }

  // ===== BACKGROUND SYNC IMPLEMENTATION =====

  Future<void> _runBackgroundSync(SyncJob syncJob,
      {required String baseUrl}) async {
    try {
      // Get resource types
      final resourceTypesResponse = await _remoteService.getResourceTypes(
        baseUrl: baseUrl,
        token: syncJob.token.token,
      );

      if (resourceTypesResponse['success'] == true) {
        final resourceTypes = resourceTypesResponse['data'] as List<dynamic>;
        final updatedJob =
            syncJob.copyWith(totalResourceTypes: resourceTypes.length);
        await _saveSyncJob(updatedJob);

        // Process each resource type
        for (int i = 0; i < resourceTypes.length; i++) {
          final resourceType = resourceTypes[i] as String;

          try {
            await _processResourceType(
              resourceType,
              baseUrl,
              syncJob.token.token,
              syncJob,
            );

            final updatedJob = syncJob.copyWith(completedResourceTypes: i + 1);
            await _saveSyncJob(updatedJob);

            // Update progress
            await _updateSyncProgress(updatedJob);
          } catch (e) {
            logger.e('❌ Failed to process resource type $resourceType: $e');
            // Continue with next resource type
          }
        }

        await _updateSyncJobStatus(SyncJobStatus.completed);
        await _updateSyncProgress(updatedJob);
      } else {
        throw Exception('Failed to get resource types');
      }
    } catch (e, s) {
      logger.e('❌ Background sync failed: $e', e, s);
      await _updateSyncJobStatus(SyncJobStatus.failed, error: e.toString());
      rethrow;
    }
  }

  Future<void> _runSmartSync(SyncJob syncJob, {required String baseUrl}) async {
    try {
      final lastSync = _prefs.getString(_lastFullSyncKey);

      if (lastSync != null) {
        // Try incremental sync first
        try {
          await syncUpdates(
            token: syncJob.token,
            baseUrl: baseUrl,
            since: lastSync,
          );
          await _updateSyncJobStatus(SyncJobStatus.completed);
          return;
        } catch (e) {
          logger.w('⚠️ Incremental sync failed, falling back to full sync: $e');
        }
      }

      // Fall back to full sync
      await _runBackgroundSync(syncJob, baseUrl: baseUrl);
    } catch (e, s) {
      logger.e('❌ Smart sync failed: $e', e, s);
      await _updateSyncJobStatus(SyncJobStatus.failed, error: e.toString());
      rethrow;
    }
  }

  Future<void> _processResourceType(
    String resourceType,
    String baseUrl,
    String token,
    SyncJob syncJob,
  ) async {
    int offset = 0;
    const limit = 1000;
    int totalProcessed = 0;

    while (true) {
      final response = await _remoteService.getResources(
        baseUrl: baseUrl,
        token: token,
        resourceType: resourceType,
        limit: limit,
        offset: offset,
      );

      if (response['success'] == true && response['data'] != null) {
        final resources = response['data'] as List<dynamic>;
        if (resources.isEmpty) break;

        // Process resources
        final processedResources = _resourceProcessor.processRawResources(
          resources,
          'created',
        );

        // Merge with local database
        await _resourceProcessor.mergeResources(
          created: processedResources,
          updated: [],
          deleted: [],
        );

        totalProcessed += processedResources.length;
        offset += limit;

        // Check if we've processed all resources
        if (resources.length < limit) break;
      } else {
        throw Exception('Failed to get resources for $resourceType');
      }
    }

    logger.d('✅ Processed $totalProcessed resources for $resourceType');
  }

  // ===== SYNC JOB MANAGEMENT =====

  Future<SyncJob?> _getCurrentSyncJob() async {
    final jobJson = _prefs.getString(_syncJobKey);
    if (jobJson == null) return null;

    try {
      final jobData = jsonDecode(jobJson) as Map<String, dynamic>;
      return SyncJob.fromJson(jobData);
    } catch (e) {
      logger.e('❌ Failed to parse sync job: $e');
      return null;
    }
  }

  Future<void> _saveSyncJob(SyncJob job) async {
    await _prefs.setString(_syncJobKey, jsonEncode(job.toJson()));
  }

  Future<void> _updateSyncJobStatus(
    SyncJobStatus status, {
    String? error,
  }) async {
    final job = await _getCurrentSyncJob();
    if (job != null) {
      final updatedJob = job.copyWith(
        status: status,
        error: error,
        endTime: (status == SyncJobStatus.completed ||
                status == SyncJobStatus.failed)
            ? DateTime.now()
            : job.endTime,
      );
      await _saveSyncJob(updatedJob);
    }
  }

  Future<void> _updateSyncProgress(SyncJob job) async {
    final progress = SyncProgress(
      currentResourceType:
          'processing', // Track current resource type being processed
      totalResourceTypes: job.totalResourceTypes,
      completedResourceTypes: job.completedResourceTypes,
      currentChunk: 0, // Track current chunk being processed
      totalChunks: 1, // Track total chunks for current resource type
      isComplete: job.status == SyncJobStatus.completed,
    );

    await _prefs.setString(_syncProgressKey, jsonEncode(progress.toJson()));
  }

  // ===== PUBLIC GETTERS =====

  Future<SyncJob?> getCurrentSyncJob() => _getCurrentSyncJob();
  Future<SyncProgress?> getSyncProgress() async {
    final progressJson = _prefs.getString(_syncProgressKey);
    if (progressJson == null) return null;

    try {
      final progressData = jsonDecode(progressJson) as Map<String, dynamic>;
      return SyncProgress.fromJson(progressData);
    } catch (e) {
      logger.e('❌ Failed to parse sync progress: $e');
      return null;
    }
  }

  Future<String?> getLastFullSyncTimestamp() async {
    return _prefs.getString(_lastFullSyncKey);
  }
}

// ===== SUPPORTING CLASSES =====

class IncrementalSyncResult {
  final int created;
  final int updated;
  final int deleted;
  final bool hasMore;
  final int nextOffset;

  IncrementalSyncResult({
    required this.created,
    required this.updated,
    required this.deleted,
    required this.hasMore,
    required this.nextOffset,
  });
}
