import 'dart:async';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/sync/data/data_source/remote/remote_sync_service.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_token.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_job.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_progress.dart';
import 'package:health_wallet/features/sync/domain/services/resource_processor.dart';

@injectable
class SyncService {
  final RemoteSyncService _remoteService;
  final SharedPreferences _prefs;
  final ResourceProcessor _resourceProcessor;

  static const String _syncJobKey = 'background_sync_job';
  static const String _syncProgressKey = 'background_sync_progress';
  static const String _lastFullSyncKey = 'last_full_sync_timestamp';

  SyncService(
    this._remoteService,
    this._prefs,
    this._resourceProcessor,
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

  // ===== BASE SYNC METHODS =====

  /// Validate token
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

  Future<void> _processResourceType(
    String resourceType,
    String baseUrl,
    String token,
    SyncJob syncJob,
  ) async {
    final resourceDtos = await _remoteService.getResources(
      baseUrl: baseUrl,
      token: token,
      resourceType: resourceType,
    );

    await _resourceProcessor.mergeResources(
      created: resourceDtos,
      updated: [],
      deleted: [],
    );
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
