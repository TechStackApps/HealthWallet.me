import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_token.dart';
import 'package:health_wallet/features/sync/domain/services/sync_service.dart';
import 'package:health_wallet/features/sync/domain/services/sync_retry_service.dart';
import 'package:health_wallet/features/sync/domain/services/sync_error_handler.dart';
import 'package:health_wallet/features/sync/data/data_source/local/fhir_local_data_source.dart';
import 'package:health_wallet/core/utils/logger.dart';

/// Result of smart sync operation
class SmartSyncResult {
  final bool wasIncrementalSync;
  final int totalChanges;
  final String? lastSyncTimestamp;
  final bool hasMore;
  final String? error;

  const SmartSyncResult({
    required this.wasIncrementalSync,
    required this.totalChanges,
    this.lastSyncTimestamp,
    this.hasMore = false,
    this.error,
  });

  bool get isSuccess => error == null;
}

/// Use case for performing smart sync (automatic incremental vs full sync)
@injectable
class PerformSmartSyncUseCase {
  final SyncService _syncService;
  final FhirLocalDataSource _fhirLocalDataSource;
  final SyncRetryService _retryService;
  final SyncErrorHandler _errorHandler;

  PerformSmartSyncUseCase(
    this._syncService,
    this._fhirLocalDataSource,
    this._retryService,
    this._errorHandler,
  );

  /// Execute smart sync operation
  /// 
  /// Automatically chooses between incremental and full sync based on:
  /// - Presence of last sync timestamp
  /// - Time elapsed since last sync
  /// - User preferences or forced full sync
  Future<SmartSyncResult> execute({
    required SyncToken token,
    required String baseUrl,
    String? resourceType,
    bool forceFullSync = false,
    Duration maxIncrementalAge = const Duration(days: 7),
  }) async {
    return _retryService.executeWithRetry(
      'smart_sync',
      () async {
        try {
          logger.i('🧠 Starting smart sync operation');
          
          // Check if we should perform incremental sync
          final lastSyncTimestamp = await _fhirLocalDataSource.getLastSyncTimestamp();
          final shouldUseIncremental = _shouldUseIncrementalSync(
            lastSyncTimestamp,
            forceFullSync,
            maxIncrementalAge,
          );

          if (shouldUseIncremental && lastSyncTimestamp != null) {
            logger.i('🔄 Performing incremental sync since: $lastSyncTimestamp');
            return await _performIncrementalSync(
              token: token,
              baseUrl: baseUrl,
              since: lastSyncTimestamp,
              resourceType: resourceType,
            );
          } else {
            logger.i('🔄 Performing full sync');
            return await _performFullSync(
              token: token,
              baseUrl: baseUrl,
              resourceType: resourceType,
            );
          }
        } catch (e, stackTrace) {
          final syncException = _errorHandler.handleError(
            e,
            operation: 'smart_sync',
            context: {
              'baseUrl': baseUrl,
              'resourceType': resourceType,
              'forceFullSync': forceFullSync,
            },
          );
          
          _errorHandler.logError(syncException, stackTrace: stackTrace);
          
          return SmartSyncResult(
            wasIncrementalSync: false,
            totalChanges: 0,
            error: _errorHandler.getUserFriendlyMessage(syncException),
          );
        }
      },
      policy: const RetryPolicy(
        maxAttempts: 2, // Fewer retries for use case level
        initialDelay: Duration(seconds: 5),
        maxDelay: Duration(minutes: 1),
      ),
      context: {
        'use_case': 'smart_sync',
        'baseUrl': baseUrl,
        'resourceType': resourceType,
      },
    );
  }

  /// Determine if incremental sync should be used
  bool _shouldUseIncrementalSync(
    String? lastSyncTimestamp,
    bool forceFullSync,
    Duration maxIncrementalAge,
  ) {
    // Force full sync overrides everything
    if (forceFullSync) {
      logger.d('📋 Full sync forced by user');
      return false;
    }

    // No previous sync means we need a full sync
    if (lastSyncTimestamp == null) {
      logger.d('📋 No previous sync found, performing full sync');
      return false;
    }

    // Check if last sync is too old
    try {
      final lastSyncTime = DateTime.parse(lastSyncTimestamp);
      final timeSinceLastSync = DateTime.now().difference(lastSyncTime);
      
      if (timeSinceLastSync > maxIncrementalAge) {
        logger.d('📋 Last sync too old (${timeSinceLastSync.inDays} days), performing full sync');
        return false;
      }
      
      logger.d('📋 Recent sync found (${timeSinceLastSync.inHours} hours ago), using incremental sync');
      return true;
    } catch (e) {
      logger.w('⚠️ Invalid last sync timestamp format: $lastSyncTimestamp');
      return false;
    }
  }

  /// Perform incremental sync
  Future<SmartSyncResult> _performIncrementalSync({
    required SyncToken token,
    required String baseUrl,
    required String since,
    String? resourceType,
  }) async {
    int totalChanges = 0;
    bool hasMore = false;
    
    try {
      // Incremental sync with pagination
      const batchSize = 1000;
      
      do {
        final result = await _syncService.syncUpdates(
          token: token,
          baseUrl: baseUrl,
          since: since,
          resourceType: resourceType,
          limit: batchSize,
        );
        
        totalChanges += (result.created + result.updated + result.deleted);
        hasMore = result.hasMore;
        
        logger.d('📊 Incremental sync batch: ${result.created + result.updated + result.deleted} changes, hasMore: $hasMore');
        
        // Break if no more data or we've processed a reasonable amount
        if (!hasMore || totalChanges > 10000) {
          break;
        }
        
      } while (hasMore);
      
      logger.i('✅ Incremental sync completed: $totalChanges total changes');
      
      return SmartSyncResult(
        wasIncrementalSync: true,
        totalChanges: totalChanges,
        lastSyncTimestamp: DateTime.now().toIso8601String(),
        hasMore: hasMore,
      );
      
    } catch (e) {
      logger.e('❌ Incremental sync failed: $e');
      rethrow;
    }
  }

  /// Perform full sync (placeholder - would integrate with background sync service)
  Future<SmartSyncResult> _performFullSync({
    required SyncToken token,
    required String baseUrl,
    String? resourceType,
  }) async {
    // TODO: Integrate with BackgroundSyncService for full sync
    logger.i('🔄 Full sync not yet implemented in use case');
    
    // For now, return a placeholder result
    return const SmartSyncResult(
      wasIncrementalSync: false,
      totalChanges: 0,
      lastSyncTimestamp: null,
      error: 'Full sync not yet implemented in use case layer',
    );
  }

  /// Get sync recommendations based on current state
  Future<Map<String, dynamic>> getSyncRecommendations() async {
    final lastSyncTimestamp = await _fhirLocalDataSource.getLastSyncTimestamp();
    final recommendations = <String, dynamic>{};
    
    if (lastSyncTimestamp == null) {
      recommendations['recommendation'] = 'full_sync';
      recommendations['reason'] = 'No previous sync found';
      recommendations['urgency'] = 'high';
    } else {
      try {
        final lastSyncTime = DateTime.parse(lastSyncTimestamp);
        final timeSinceLastSync = DateTime.now().difference(lastSyncTime);
        
        if (timeSinceLastSync.inDays > 7) {
          recommendations['recommendation'] = 'full_sync';
          recommendations['reason'] = 'Last sync was ${timeSinceLastSync.inDays} days ago';
          recommendations['urgency'] = 'medium';
        } else if (timeSinceLastSync.inHours > 24) {
          recommendations['recommendation'] = 'incremental_sync';
          recommendations['reason'] = 'Last sync was ${timeSinceLastSync.inHours} hours ago';
          recommendations['urgency'] = 'low';
        } else {
          recommendations['recommendation'] = 'no_sync_needed';
          recommendations['reason'] = 'Recent sync found';
          recommendations['urgency'] = 'none';
        }
        
        recommendations['lastSyncTime'] = lastSyncTime.toIso8601String();
        recommendations['timeSinceLastSync'] = {
          'days': timeSinceLastSync.inDays,
          'hours': timeSinceLastSync.inHours,
          'minutes': timeSinceLastSync.inMinutes,
        };
      } catch (e) {
        recommendations['recommendation'] = 'full_sync';
        recommendations['reason'] = 'Invalid last sync timestamp';
        recommendations['urgency'] = 'medium';
      }
    }
    
    return recommendations;
  }
}
