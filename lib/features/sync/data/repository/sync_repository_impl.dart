import 'dart:convert';
import 'dart:developer';

import 'package:health_wallet/features/sync/data/data_source/local/sync_local_data_source.dart';
import 'package:health_wallet/features/sync/data/data_source/remote/sync_remote_data_source.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart'
    as entity;
import 'package:health_wallet/features/sync/domain/entities/sync_qr_data.dart';
import 'package:health_wallet/features/sync/domain/repository/sync_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/sync/data/dto/fhir_resource_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: SyncRepository)
class SyncRepositoryImpl implements SyncRepository {
  final SyncRemoteDataSource _remoteDataSource;
  final SyncLocalDataSource _localDataSource;
  final SharedPreferences _prefs;

  SyncRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._prefs,
  );

  static const String _tokenKey = 'sync_token';

  @override
  Future<void> syncResources({required String endpoint}) async {
    // Fetch incoming data and current local data
    final List<FhirResourceDto> incomingResources =
        await _remoteDataSource.getResources(endpoint: endpoint);
    final List<FhirResourceDto> currentResources =
        await _localDataSource.getAllFhirResources();

    // Organize current data into a Map for efficient lookups
    final Map<String, FhirResourceDto> currentResourcesMap = {
      for (var resource in currentResources)
        if (resource.resourceId != null) resource.resourceId!: resource
    };

    // Process incoming data with the lastUpdated check
    final List<FhirResourceDto> resourcesToUpsert = [];

    final processedIncoming = incomingResources
        .map((res) =>
            res.populateEncounterIdFromRaw().populateSubjectIdFromRaw())
        .toList();

    for (final incomingResource in processedIncoming) {
      if (incomingResource.resourceId == null) continue;

      final resourceId = incomingResource.resourceId!;

     if (currentResourcesMap.containsKey(resourceId)) {
        // Record exists, so check if it has been updated
        final localResource = currentResourcesMap[resourceId]!;

        // Compare the 'lastUpdated' timestamp.
        // We only update if the incoming date is newer than the local one.
        final incomingDate = incomingResource.updatedAt;
        final localDate = localResource.updatedAt;

        if (incomingDate != null &&
            (localDate == null || incomingDate.isAfter(localDate))) {
          // The incoming record is newer, so add it for an update.
          resourcesToUpsert.add(incomingResource);
        }
        // If the incoming record is not newer, we do nothing, skipping the unnecessary write.
      } else {
        // Record does not exist locally, so it's new.
        resourcesToUpsert.add(incomingResource);
      }
    }

    if (resourcesToUpsert.isNotEmpty) {
      await _localDataSource.cacheFhirResources(resourcesToUpsert);
    }

    await _localDataSource
        .setLastSyncTimestamp(DateTime.now().toIso8601String());
  }

  @override
  Future<String?> getLastSyncTimestamp() {
    return _localDataSource.getLastSyncTimestamp();
  }

  @override
  Future<List<entity.Source>> getSources() async {
    final sources = await _localDataSource.getSources();
    return sources
        .map(
          (e) => entity.Source(
            id: e.id,
            name: e.name ?? '',
            logo: e.logo,
            labelSource: e.labelSource,
          ),
        )
        .toList();
  }

  @override
  void setBaseUrl(String baseUrl) {
    if (!baseUrl.endsWith("/")) {
      baseUrl += "/";
    }
    _remoteDataSource.updateBaseUrl(baseUrl);
  }

  @override
  void setBearerToken(String token) {
    _remoteDataSource.updateAuthorizationToken(token);
  }

  @override
  Future<void> saveSyncQrData(SyncQrData qrData) async {
    await _prefs.setString(_tokenKey, jsonEncode(qrData.toJson()));
  }

  @override
  Future<SyncQrData?> getCurrentSyncQrData() async {
    final qrDataJsonString = _prefs.getString(_tokenKey);
    if (qrDataJsonString == null) return null;

    try {
      final qrDataJson = jsonDecode(qrDataJsonString) as Map<String, dynamic>;
      final qrData = SyncQrData.fromJson(qrDataJson);

      if (qrData.tokenMeta.isExpired) {
        await clearToken();
        return null;
      }

      return qrData;
    } catch (e) {
      await clearToken();
      return null;
    }
  }

  @override
  Future<void> updateSourceLabel(String sourceId, String newLabel) async {
    return _localDataSource.updateSourceLabel(sourceId, newLabel);
  }

  Future<void> clearToken() async {
    log("remove");
    await _prefs.remove(_tokenKey);
  }
}
