import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:health_wallet/features/sync/data/data_source/local/fhir_local_data_source.dart';
import 'package:health_wallet/features/sync/data/data_source/remote/fhir_api_service.dart';
import 'package:health_wallet/features/sync/domain/entities/fhir_bundle.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:health_wallet/features/sync/domain/repository/fhir_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FhirRepository)
class FhirRepositoryImpl implements FhirRepository {
  final FhirApiService _fhirApiService;
  final FhirLocalDataSource _fhirLocalDataSource;

  FhirRepositoryImpl(this._fhirApiService, this._fhirLocalDataSource);

  @override
  Future<void> syncData() async {
    try {
      final initiationResponse = await _fhirApiService.initiateSync();
      final token = initiationResponse.data?['data']?['token'];
      final address = initiationResponse.data?['data']?['address'];
      final port = initiationResponse.data?['data']?['port'];

      if (token != null && address != null && port != null) {
        await _sync(token, address, port);
      }
    } catch (e, s) {
      print('Error in syncData: $e');
      print(s);
      rethrow;
    }
  }

  @override
  Future<void> syncDataWithJson(String jsonData) async {
    try {
      print('--- Sync Data with JSON ---');
      print('Received JSON data: $jsonData');
      final decodedData = jsonDecode(jsonData);
      final token = decodedData['token'];
      final address = decodedData['address'];
      final port = decodedData['port'];

      print('Token: $token');
      print('Address: $address');
      print('Port: $port');

      if (token != null && address != null && port != null) {
        await _sync(token, address, port);
      }
    } catch (e, s) {
      print('Error in syncDataWithJson: $e');
      print(s);
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

    if (lastSyncTimestamp != null) {
      dataResponse = await tempApiService.syncDataUpdates(lastSyncTimestamp);
    } else {
      dataResponse = await tempApiService.syncData();
    }

    final responseData = dataResponse.data;
    print("--- Raw Response Data ---");
    print("Type: ${responseData.runtimeType}");
    print("Data: $responseData");

    if (responseData is Map<String, dynamic>) {
      final bundle = FhirBundle.fromJson(responseData);
      final resources = bundle.entry.map((e) => e.resource).toList();
      final sources = <Source>[];
      final sourceIds = <String>{};

      for (final resource in resources) {
        final sourceId = resource.sourceId;
        if (sourceId != null && !sourceIds.contains(sourceId)) {
          sources.add(Source(
            id: sourceId,
            name: resource.resourceJson['source_name'] ?? sourceId,
            logo: resource.resourceJson['logo'] as String?,
          ));
          sourceIds.add(sourceId);
        }
      }
      print('--- Extracted sources ---');
      print(sources);

      print('--- FHIR Resources ---');
      for (var resource in resources) {
        // print(resource.toJson());
      }

      if (lastSyncTimestamp == null) {
        await _fhirLocalDataSource.deleteAllFhirResources();
        await _fhirLocalDataSource.deleteAllSources();
      }

      // Group resources by sourceId and cache per source
      final Map<String, List<FhirResource>> resourcesBySource = {};
      for (final resource in resources) {
        final sid = resource.sourceId ?? 'unknown';
        resourcesBySource.putIfAbsent(sid, () => []).add(resource);
      }
      for (final entry in resourcesBySource.entries) {
        await _fhirLocalDataSource.cacheFhirResources(entry.value,
            sourceId: entry.key);
      }
      await _fhirLocalDataSource.cacheSources(sources);
      // if (bundle.lastUpdated != null) {
      //   await _fhirLocalDataSource
      //       .setLastSyncTimestamp(bundle.lastUpdated!);
      // }
    }
  }

  @override
  Future<List<FhirResource>> getResources(
      {String? resourceType, String? sourceId}) async {
    final resources =
        await _fhirLocalDataSource.getFhirResources(sourceId: sourceId);
    if (resourceType != null) {
      return resources
          .where((element) => element.resourceType == resourceType)
          .toList();
    }
    return resources;
  }

  @override
  Future<List<Source>> getSources() async {
    final sources = await _fhirLocalDataSource.getSources();
    return sources
        .map(
          (e) => Source(
            id: e.id,
            name: e.name ?? '',
            logo: e.logo,
          ),
        )
        .toList();
  }
}
