import 'dart:convert';
import 'package:health_wallet/features/sync/data/data_source/local/fhir_local_data_source.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/sync/data/data_source/remote/fhir_api_service.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart'
    as entity;
import 'package:health_wallet/features/sync/domain/repository/sync_repository.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_token.dart';
import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/user/domain/repository/user_repository.dart';
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
  final UserRepository _userRepository;
  final SyncService _syncService;

  SyncRepositoryImpl(
    this._fhirApiService,
    this._fhirLocalDataSource,
    this._tokenService,
    this._userRepository,
    this._syncService,
  );

  @override
  Future<void> syncData() async {
    try {
      // Redirect to new background sync approach
      await startBackgroundSync();
    } catch (e, s) {
      logger.e('Error in syncData: $e', e, s);
      rethrow;
    }
  }

  @override
  Future<void> syncDataWithJson(String jsonData) async {
    try {
      logger.d('--- Background Sync with JSON ---');
      logger.d('Received JSON data: $jsonData');
      final decodedData = jsonDecode(jsonData);

      // Only handle server connection data for background sync
      if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey('token') &&
          decodedData.containsKey('server')) {
        // Handle server connection data and start background sync
        final token =
            await _tokenService.createTokenFromSyncData(decodedData);
        await _tokenService.saveToken(token);

        logger.d('Processing server connection data for background sync');
        logger.d('Token: ${token.token}');
        logger.d('Address: ${token.address}');
        logger.d('Port: ${token.port}');

        // Start background sync process
        await startBackgroundSync();
      } else {
        throw Exception(
            'Invalid JSON format. Expected server connection data (token, server) for background sync');
      }
    } catch (e, s) {
      logger.e('Error in syncDataWithJson: $e', e, s);
      rethrow;
    }
  }

  @override
  Future<void> cacheResources(List<FhirResourceDto> resources) async {
    await _fhirLocalDataSource.cacheFhirResources(resources);
    await _fhirLocalDataSource
        .setLastSyncTimestamp(DateTime.now().toIso8601String());
  }

  /// Start background sync using the new chunked approach
  Future<void> startBackgroundSync({String? workingBaseUrl}) async {
    final currentToken = await _tokenService.getCurrentToken();
    if (currentToken == null) {
      throw Exception('No valid token available for background sync');
    }

    // Use SyncToken directly - no more conversion needed!
    await _syncService.startBackgroundSync(currentToken,
        workingBaseUrl: workingBaseUrl);
  }

  /// Start smart sync that automatically chooses between full and incremental
  Future<void> startSmartSync({String? workingBaseUrl}) async {
    final currentToken = await _tokenService.getCurrentToken();
    if (currentToken == null) {
      throw Exception('No valid token available for smart sync');
    }

    // Use smart sync that chooses the best approach
    await _syncService.startSmartSync(currentToken,
        workingBaseUrl: workingBaseUrl);
  }

  /// Check if background sync is running
  Future<bool> isBackgroundSyncRunning() async {
    final job = await _syncService.getCurrentSyncJob();
    return job?.status == SyncJobStatus.running;
  }

  /// Get current sync progress
  Future<dynamic> getCurrentSyncProgress() async {
    return await _syncService.getSyncProgress();
  }

  /// Cancel background sync
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
