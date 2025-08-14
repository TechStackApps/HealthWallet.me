import 'package:dio/dio.dart';
import 'package:health_wallet/features/sync/data/dto/fhir_bundle.dart';
import 'package:health_wallet/features/user/data/dto/user_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/sync/domain/entities/ssdp_service_info.dart';
import 'package:health_wallet/core/utils/logger.dart';

@injectable
class FhirApiService {
  final Dio _dio;

  FhirApiService(this._dio);

  /// Updates the base URL for the Dio instance when connecting to a service
  void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  /// Connects to a specific service by updating the base URL
  Future<void> connectToService(SSDPServiceInfo service) async {
    final baseUrl = 'http://${service.serverAddress}:${service.serverPort}/api';
    updateBaseUrl(baseUrl);
  }

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
    // Base URL should include /api; health endpoint is public
    return _dio.get('/health');
  }

  // Convenience helpers to work with a specific Fasten service endpoint
  Future<bool> testConnectionToService(SSDPServiceInfo service) async {
    try {
      // Use unauthenticated mobile sync endpoint to validate server and get token
      final dio = Dio(
        BaseOptions(
          baseUrl: service.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
        ),
      );

      final response = await dio.get('/api/mobile/sync');
      if (response.statusCode != 200) return false;

      final data = response.data;
      if (data is Map<String, dynamic>) {
        final success = data['success'] == true;
        final endpoints = (data['data'] ?? {})['endpoints'];
        return success && endpoints != null;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<void> disconnectFromService(SSDPServiceInfo service) async {
    // No persistent connection to close; kept for API symmetry and logging if needed
    return;
  }

  /// Fetches mobile sync bootstrap data (endpoints, token, expiry) from a service
  Future<Map<String, dynamic>> getMobileSyncData(
      SSDPServiceInfo service) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: service.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
      ),
    );

    final response = await dio.get('/api/mobile/sync');
    if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
      return Map<String, dynamic>.from(response.data as Map);
    }
    throw Exception('Failed to fetch mobile sync data');
  }

  /// Fetch current user information from the sync server
  /// Returns null if user data cannot be fetched, making it truly optional
  Future<UserDto?> fetchCurrentUser() async {
    try {
      final response = await _dio.get('/secure/account/me');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final userData = response.data['data']['user'] as Map<String, dynamic>;

        // Log the actual data being received for debugging
        logger.d('📊 Received user data from /secure/account/me: $userData');

        // Check if we have the required fields
        if (userData['id'] != null && userData['username'] != null) {
          return UserDto.fromJson(userData);
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
