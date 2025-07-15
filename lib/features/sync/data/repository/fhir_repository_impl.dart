import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:health_wallet/features/sync/data/data_source/local/fhir_local_data_source.dart';
import 'package:health_wallet/features/sync/data/data_source/remote/fhir_api_service.dart';
import 'package:health_wallet/features/sync/domain/entities/fhir_bundle.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart'
    as entity;
import 'package:collection/collection.dart';
import 'package:health_wallet/features/sync/domain/repository/fhir_repository.dart';
import 'package:health_wallet/features/sync/domain/services/sync_token_service.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_token.dart';
import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/records/data/repository/records_repository.dart';
import 'package:health_wallet/features/records/data/datasource/fhir_resource_datasource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:get_it/get_it.dart';

@Injectable(as: FhirRepository)
class FhirRepositoryImpl implements FhirRepository {
  final FhirApiService _fhirApiService;
  final FhirLocalDataSource _fhirLocalDataSource;
  final SyncTokenService _syncTokenService;

  FhirRepositoryImpl(
    this._fhirApiService,
    this._fhirLocalDataSource,
    this._syncTokenService,
  );

  @override
  Future<void> syncData() async {
    try {
      // Check if we have a valid token
      final currentToken = await _syncTokenService.getCurrentToken();
      if (currentToken == null) {
        // Try to get a new token through initiation
        final initiationResponse = await _fhirApiService.initiateSync();
        final data = initiationResponse.data?['data'] as Map<String, dynamic>?;

        if (data != null) {
          final token = await _syncTokenService.createTokenFromSyncData(data);
          await _syncTokenService.saveToken(token);
          await _sync(token.token, token.address, token.port);
        }
      } else {
        // Use existing token
        await _sync(
            currentToken.token, currentToken.address, currentToken.port);
      }
    } catch (e, s) {
      logger.e('Error in syncData: $e', e, s);
      rethrow;
    }
  }

  @override
  Future<void> syncDataWithJson(String jsonData) async {
    try {
      logger.d('--- Sync Data with JSON ---');
      logger.d('Received JSON data: $jsonData');
      final decodedData = jsonDecode(jsonData);

      // Check if this is server connection data (has token, address, port)
      if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey('token') &&
          decodedData.containsKey('address') &&
          decodedData.containsKey('port')) {
        // Handle server connection data
        final token =
            await _syncTokenService.createTokenFromSyncData(decodedData);
        await _syncTokenService.saveToken(token);

        logger.d('Processing server connection data');
        logger.d('Token: ${token.token}');
        logger.d('Address: ${token.address}');
        logger.d('Port: ${token.port}');

        await _sync(token.token, token.address, token.port);
      } else if (decodedData is Map<String, dynamic> &&
          decodedData.containsKey('resourceType') &&
          decodedData['resourceType'] == 'Bundle') {
        logger.d('Processing direct FHIR Bundle data');
        await _processFhirBundle(decodedData, 'manual-import');
      } else {
        throw Exception(
            'Invalid JSON format. Expected either server connection data (token, address, port) or FHIR Bundle (resourceType: Bundle)');
      }
    } catch (e, s) {
      logger.e('Error in syncDataWithJson: $e', e, s);
      rethrow;
    }
  }

  Future<void> _sync(String token, String address, String port) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://$address:$port/api',
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    final tempApiService = FhirApiService(dio);
    final lastSyncTimestamp = await _fhirLocalDataSource.getLastSyncTimestamp();
    dynamic dataResponse;

    try {
      if (lastSyncTimestamp != null) {
        logger.d('Syncing updates since: $lastSyncTimestamp');
        dataResponse = await tempApiService.syncDataUpdates(lastSyncTimestamp);
      } else {
        logger.d('Full sync - no previous sync timestamp');
        dataResponse = await tempApiService.syncData();
      }

      final responseData = dataResponse.data;
      logger.d("--- Raw Response Data ---");
      logger.d("Type: ${responseData.runtimeType}");

      if (responseData is Map<String, dynamic>) {
        await _processFhirBundle(responseData, '$address:$port');

        // Update last sync timestamp
        await _fhirLocalDataSource
            .setLastSyncTimestamp(DateTime.now().toIso8601String());
      }
    } catch (e, s) {
      logger.e('Error during sync: $e', e, s);
      rethrow;
    }
  }

  Future<void> _processFhirBundle(
      Map<String, dynamic> responseData, String sourceId) async {
    logger.d('Raw FHIR bundle: $responseData');

    final bundle = FhirBundle.fromJson(responseData);
    final resources = bundle.entry.map((e) => e.resource).toList();

    // Attempt to find a better sourceId from the bundle
    final organization = resources.firstWhereOrNull(
        (r) => r.resourceType.toLowerCase() == 'organization');
    final newSourceId = organization?.id ?? sourceId;
    final sourceName = organization?.resourceJson['name'] ?? newSourceId;

    // Check if we already have data from this source at this timestamp
    final existingData = await _checkForExistingData(newSourceId, responseData);
    if (existingData) {
      logger.d('Skipping duplicate data from source: $newSourceId');
      return;
    }

    // Use RecordsRepository for proper FHIR Bundle import
    final recordsRepository = RecordsRepository(GetIt.instance<AppDatabase>());

    logger.d('--- Using RecordsRepository for FHIR Bundle import ---');
    final importSummary = await recordsRepository.importFhirBundle(
        jsonEncode(responseData), newSourceId);
    logger.d('Import summary: $importSummary');

    // Process sources and metadata
    final sources = <entity.Source>[];
    final sourceIds = <String>{};

    // Create source for this import
    if (!sourceIds.contains(newSourceId)) {
      sources.add(entity.Source(
        id: newSourceId,
        name: newSourceId == 'manual-import' ? 'Manual Import' : sourceName,
        logo: null,
      ));
      sourceIds.add(newSourceId);
    }

    // Also extract any sources from resource metadata if present
    for (final resource in resources) {
      final resourceSourceId = resource.sourceId;
      if (resourceSourceId != null && !sourceIds.contains(resourceSourceId)) {
        sources.add(entity.Source(
          id: resourceSourceId,
          name: resource.resourceJson['source_name'] ?? resourceSourceId,
          logo: resource.resourceJson['logo'] as String?,
        ));
        sourceIds.add(resourceSourceId);
      }
    }

    logger.d('--- Extracted sources ---');
    logger.d(sources);

    // Cache sources (metadata) only if we have new ones
    if (sources.isNotEmpty) {
      await _fhirLocalDataSource.cacheSources(sources);
    }

    logger.d(
        '--- Bundle processing completed successfully with ${importSummary.values.fold(0, (a, b) => a + b)} resources ---');
  }

  Future<bool> _checkForExistingData(
      String sourceId, Map<String, dynamic> bundleData) async {
    try {
      // Check if we have a recent timestamp for this source
      final lastSyncTimestamp =
          await _fhirLocalDataSource.getLastSyncTimestamp();

      if (lastSyncTimestamp != null) {
        final lastSync = DateTime.parse(lastSyncTimestamp);
        final now = DateTime.now();

        // If last sync was less than 5 minutes ago, consider it recent
        if (now.difference(lastSync).inMinutes < 5) {
          logger.d('Recent sync detected, checking for duplicate data');

          // Get existing sources
          final existingSources = await _fhirLocalDataSource.getSources();
          final hasSourceAlready = existingSources.any((s) => s.id == sourceId);

          if (hasSourceAlready) {
            // Check if the bundle has the same number of resources
            final bundleTotal = bundleData['total'] as int? ?? 0;
            if (bundleTotal == 0) {
              logger.d('Empty bundle detected, skipping duplicate check');
              return false;
            }

            // Additional check: compare bundle entry count with existing data
            final bundleEntries = bundleData['entry'] as List<dynamic>? ?? [];
            if (bundleEntries.isEmpty) {
              logger.d('No bundle entries, likely duplicate');
              return true;
            }
          }
        }
      }

      return false;
    } catch (e) {
      logger.e('Error checking for existing data: $e');
      return false; // If we can't check, proceed with import
    }
  }

  @override
  Future<List<FhirResource>> getResources(
      {String? resourceType, String? sourceId}) async {
    logger.d('Getting resources of type: $resourceType for source: $sourceId');
    final datasource = FhirResourceDatasource(GetIt.instance<AppDatabase>());

    if (resourceType != null) {
      final resources = await datasource.getAllResources(
        resourceType,
        sourceId: sourceId,
      );
      logger.d('Found ${resources.length} resources');
      // Convert to old FhirResource format for compatibility
      return resources
          .map((resource) => FhirResource(
                id: resource['id'] as String?,
                resourceType: resource['resourceType'] as String,
                resourceJson: resource,
                sourceId: sourceId,
                updatedAt: DateTime.now(),
              ))
          .toList();
    }

    // If no resourceType specified, return empty list
    return [];
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

  @override
  Future<List<FhirResource>> getEncounterWithReferences(String encounterId) {
    return _fhirLocalDataSource.getEncounterWithReferences(encounterId);
  }
}
