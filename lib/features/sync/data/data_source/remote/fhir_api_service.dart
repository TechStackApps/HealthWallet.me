import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class FhirApiService {
  final Dio _dio;

  FhirApiService(this._dio);

  Future<Response<Map<String, dynamic>>> initiateSync() async {
    return _dio.get('/secure/sync/initiate');
  }

  Future<Response<Map<String, dynamic>>> syncData() async {
    return _dio.get('/secure/sync/data');
  }

  Future<Response<Map<String, dynamic>>> getLastUpdated() async {
    return _dio.get('/secure/sync/last-updated');
  }

  Future<Response<Map<String, dynamic>>> syncDataUpdates(String since) async {
    return _dio.get('/secure/sync/updates', queryParameters: {'since': since});
  }

  Future<Response<Map<String, dynamic>>> checkToken(String token) async {
    return _dio
        .get('/secure/sync/token/check', queryParameters: {'token': token});
  }

  Future<Response<Map<String, dynamic>>> ping() async {
    return _dio.get('/secure/ping');
  }
}
