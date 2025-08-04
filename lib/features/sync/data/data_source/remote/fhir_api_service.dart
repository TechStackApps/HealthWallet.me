import 'package:dio/dio.dart';
import 'package:health_wallet/features/sync/data/dto/fhir_bundle.dart';
import 'package:injectable/injectable.dart';

@injectable
class FhirApiService {
  final Dio _dio;

  FhirApiService(this._dio);

  Future<Response<Map<String, dynamic>>> initiateSync() async {
    return _dio.get('/secure/sync/initiate');
  }

  Future<FhirBundle> syncData() async {
    Response response = await _dio.get('/secure/sync/data');

    return FhirBundle.fromJson(response.data);
  }

  Future<Response<Map<String, dynamic>>> getLastUpdated() async {
    return _dio.get('/secure/sync/last-updated');
  }

  Future<FhirBundle> syncDataUpdates(String since) async {
    Response response = await _dio
        .get('/secure/sync/updates', queryParameters: {'since': since});

    return FhirBundle.fromJson(response.data);
  }

  Future<Response<Map<String, dynamic>>> checkToken(String token) async {
    return _dio
        .get('/secure/sync/token/check', queryParameters: {'token': token});
  }

  Future<Response<Map<String, dynamic>>> ping() async {
    return _dio.get('/secure/ping');
  }
}
