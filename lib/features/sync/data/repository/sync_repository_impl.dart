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
    List<FhirResourceDto> resources =
        await _remoteDataSource.getResources(endpoint: endpoint);

    await _localDataSource.cacheFhirResources(resources);
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

  Future<void> clearToken() async {
    log("remove");
    await _prefs.remove(_tokenKey);
  }
}
