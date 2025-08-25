import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/sync/data/data_source/remote/response_handler.dart';
import 'package:health_wallet/core/utils/logger.dart';

@injectable
class FhirApiService {
  final Dio _dio;
  final ResponseHandler _responseHandler;

  FhirApiService(this._dio, this._responseHandler);

  /// Updates the base URL for the Dio instance when connecting to a service
  void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  /// Updates the authorization token for the Dio instance
  void updateAuthorizationToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Makes a GET request with common error handling
  Future<Map<String, dynamic>> _makeGetRequest(
    String endpoint, {
    Map<String, String>? queryParameters,
    String operation = 'GET request',
  }) async {
    try {
      final response =
          await _dio.get(endpoint, queryParameters: queryParameters);
      return _responseHandler.handleResponse(response, operation);
    } catch (e) {
      logger.e('❌ $operation failed: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> initiateSync() async {
    return _makeGetRequest('/api/secure/sync/initiate',
        operation: 'Initiate sync');
  }

  Future<Map<String, dynamic>> getLastUpdated() async {
    return _makeGetRequest('/api/secure/sync/status',
        operation: 'Get sync status');
  }

  Future<Map<String, dynamic>> checkToken(String token) async {
    return _makeGetRequest('/api/secure/sync/discovery',
        operation: 'Check token');
  }

  Future<Map<String, dynamic>> ping() async {
    return _makeGetRequest('/health', operation: 'Health check');
  }

  /// Fetch current user information from the sync server
  Future<Map<String, dynamic>?> fetchCurrentUser() async {
    try {
      final token = _dio.options.headers['Authorization']
              ?.toString()
              .replaceFirst('Bearer ', '') ??
          '';

      if (token.isEmpty) {
        logger.w('⚠️ No authorization token available for user fetch');
        return null;
      }

      logger.d('🔑 Using token for user fetch: ${token.substring(0, 20)}...');

      final response = await _dio.get('/api/secure/account/me');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final userData = response.data['data'] as Map<String, dynamic>;
        logger
            .d('📊 Received user data from /api/secure/account/me: $userData');

        if (userData['id'] != null && userData['username'] != null) {
          return userData;
        } else {
          logger.w('⚠️ User data missing required fields: id or username');
          return null;
        }
      } else {
        logger.w(
            '⚠️ Account endpoint returned error: ${response.data['error'] ?? 'Unknown error'}');
        return null;
      }
    } catch (e) {
      logger.e('❌ Error fetching current user: $e');
      return null;
    }
  }
}
