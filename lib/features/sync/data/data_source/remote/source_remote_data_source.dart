import 'package:dio/dio.dart';
import 'package:health_wallet/features/sync/data/dto/source_dto.dart';
import 'package:health_wallet/features/sync/data/mappers/source_mapper.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:injectable/injectable.dart';

@injectable
class SourceRemoteDataSource {
  final Dio _dio;
  final SourceMapper _sourceMapper;

  SourceRemoteDataSource(this._dio, this._sourceMapper);

  void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  void updateAuthorizationToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Fetch sources from the fasten-onprem backend API
  Future<List<Source>> getSources() async {
    try {
      final response = await _dio.get('/api/secure/source');
      final responseData = response.data;

      if (responseData['success'] == true && responseData['data'] != null) {
        final sourceDtos = (responseData['data'] as List)
            .whereType<Map<String, dynamic>>()
            .map((json) => SourceDto.fromJson(json))
            .toList();

        return _sourceMapper.mapToEntities(sourceDtos);
      }

      return [];
    } catch (e) {
      return [];
    }
  }
}
