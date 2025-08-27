import 'package:health_wallet/features/sync/data/data_source/local/fhir_local_data_source.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/sync/data/data_source/remote/fhir_api_service.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart'
    as entity;
import 'package:health_wallet/features/sync/domain/repository/sync_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/sync/data/dto/fhir_resource_dto.dart';
import 'package:health_wallet/features/sync/domain/services/sync_service.dart';
import 'package:health_wallet/features/sync/domain/services/token_service.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_job.dart';

@Injectable(as: SyncRepository)
class SyncRepositoryImpl implements SyncRepository {
  // Keep reference for potential future use (e.g., streaming sync); currently unused
  // ignore: unused_field
  final FhirApiService _fhirApiService;
  final FhirLocalDataSource _fhirLocalDataSource;
  final TokenService _tokenService;
  final SyncService _syncService;

  SyncRepositoryImpl(
    this._fhirApiService,
    this._fhirLocalDataSource,
    this._tokenService,
    this._syncService,
  );

  @override
  Future<void> cacheResources(List<FhirResourceDto> resources) async {
    await _fhirLocalDataSource.cacheFhirResources(resources);
    await _fhirLocalDataSource
        .setLastSyncTimestamp(DateTime.now().toIso8601String());
  }

  /// Start background sync using the new chunked approach
  @override
  Future<void> startBackgroundSync({required String baseUrl}) async {
    final currentToken = await _tokenService.getCurrentToken();
    if (currentToken == null) {
      throw Exception('No valid token available for background sync');
    }

    // Use SyncToken directly - no more conversion needed!
    await _syncService.startBackgroundSync(currentToken,
        baseUrl: baseUrl);
  }

  /// Check if background sync is running
  @override
  Future<bool> isBackgroundSyncRunning() async {
    final job = await _syncService.getCurrentSyncJob();
    return job?.status == SyncJobStatus.running;
  }

  /// Get current sync progress
  @override
  Future<dynamic> getCurrentSyncProgress() async {
    return await _syncService.getSyncProgress();
  }

  /// Cancel background sync
  @override
  Future<void> cancelBackgroundSync() async {
    // Note: Cancel functionality would need to be implemented in SyncService
    // For now, we'll just log that cancellation was requested
    logger.w('Cancel background sync requested - functionality not yet implemented');
  }

  @override
  Future<List<entity.Source>> getSources() async {
    final sources = await _fhirLocalDataSource.getSources();
    return sources
        .map(
          (e) => entity.Source(
            id: e.id,
            name: e.name ?? '',
            logo: e.logo,
          ),
        )
        .toList();
  }
}
