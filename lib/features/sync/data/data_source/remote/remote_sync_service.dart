import 'package:dio/dio.dart';
import 'package:health_wallet/features/sync/data/dto/fhir_resource_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/sync/data/data_source/remote/response_handler.dart';
import 'package:health_wallet/features/sync/domain/exceptions/sync_exception.dart';
import 'package:health_wallet/core/utils/logger.dart';

@injectable
class RemoteSyncService {
  final ResponseHandler _responseHandler;

  RemoteSyncService(this._responseHandler);

  // ===== HTTP CLIENT FACTORY METHODS =====

  Dio _createClient({
    required String baseUrl,
    required String token,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout ?? const Duration(seconds: 30),
      receiveTimeout: receiveTimeout ?? const Duration(seconds: 30),
      sendTimeout: sendTimeout ?? const Duration(seconds: 30),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add logging interceptor
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => logger.d(obj.toString()),
    ));

    return dio;
  }

  Dio _createHealthCheckClient({required String baseUrl}) {
    return Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    ));
  }

  // ===== SYNC DATA METHODS =====

  /// Sync data using QR configuration
  Future<Map<String, dynamic>> syncData({
    required String baseUrl,
    required String token,
    required String endpoint,
  }) async {
    try {
      logger.d('🔄 Sync data API call starting...');
      logger.d('🌐 Base URL: $baseUrl');
      logger.d('🔗 Endpoint: $endpoint');
      logger.d('🔑 Token: ${token.substring(0, 20)}...');

      final dio = _createClient(
        baseUrl: baseUrl,
        token: token,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      );

      logger.d('🚀 Making GET request to: $baseUrl$endpoint');
      final response = await dio.get(endpoint);

      logger.d('📡 Response received');
      logger.d('📊 Status Code: ${response.statusCode}');
      logger.d('📋 Response Headers: ${response.headers}');
      logger.d('📄 Response Data Type: ${response.data.runtimeType}');
      logger.d('📄 Response Data: ${response.data}');

      return _responseHandler.handleResponse(response, 'Sync data');
    } catch (e) {
      logger.e('❌ Sync data failed: $e');
      logger.e('🔍 Error type: ${e.runtimeType}');
      rethrow;
    }
  }

  /// Get sync updates using QR configuration (legacy method)
  Future<Map<String, dynamic>> getSyncUpdates({
    required String baseUrl,
    required String token,
    required String endpoint,
  }) async {
    try {
      final dio = _createClient(
        baseUrl: baseUrl,
        token: token,
      );

      // We expect the caller to include query params in endpoint (e.g., /api/secure/sync/updates?since=...)
      final response = await dio.get(endpoint);
      return _responseHandler.handleResponse(response, 'Get sync updates');
    } catch (e) {
      logger.e('❌ Get sync updates failed: $e');
      rethrow;
    }
  }

  /// Get resource types from the server
  /// Since the server doesn't have this endpoint, we'll use a predefined list
  /// of common FHIR resource types that are typically available
  Future<Map<String, dynamic>> getResourceTypes({
    required String baseUrl,
    required String token,
  }) async {
    try {
      logger
          .d('📋 Getting resource types - using predefined FHIR resource list');

      // Return a predefined list of common FHIR resource types
      // This is a fallback since the server doesn't have the endpoint
      return {
        'success': true,
        'data': [
          'Patient', // Basic patient demographics
          'Observation', // Vital signs, lab results, measurements
          'Condition', // Health issues, diagnoses
          'MedicationRequest', // Prescriptions, medication orders
          'Procedure', // Medical procedures performed
          'Immunization', // Vaccines given
          'DiagnosticReport', // Lab reports, imaging reports
          'CarePlan', // Treatment plans
          'Goal', // Health goals
          'CareTeam', // Healthcare team members
          'Practitioner', // Doctors, nurses, etc.
          'Organization', // Hospitals, clinics
          'Encounter', // Patient visits
          'AllergyIntolerance', // Allergies
          'Medication', // Medication definitions
          'Specimen', // Lab specimens
          'DocumentReference', // Clinical documents
          'Binary', // Files, images
          'Media', // Multimedia content
          'Location', // Physical locations
          'Coverage', // Insurance coverage
          'Claim', // Insurance claims
        ],
        'message':
            'Using predefined FHIR resource types (server endpoint not available)',
        'source': 'fallback',
      };
    } catch (e) {
      logger.e('❌ Get resource types failed: $e');
      rethrow;
    }
  }

  Future<List<FhirResourceDto>> getResources({
    required String baseUrl,
    required String token,
    required String resourceType,
  }) async {
    try {
      final dio = _createClient(
        baseUrl: baseUrl,
        token: token,
      );

      final response = await dio.get(
        '/api/secure/resource/fhir',
        queryParameters: {
          'sourceResourceType':
              resourceType,
        },
      );

      final responseData =
          _responseHandler.handleResponse(response, 'Get resources');

      if (responseData['data'] == null) {
        return [];
      }

      return (responseData['data'] as List)
          .whereType<Map<String, dynamic>>()
          .map(FhirResourceDto.fromJson)
          .toList();
    } catch (e) {
      logger.e('❌ Get resources failed: $e');
      rethrow;
    }
  }

  // ===== INCREMENTAL SYNC METHODS =====

  /// Get incremental updates since a specific timestamp
  Future<Map<String, dynamic>> getIncrementalUpdates({
    required String baseUrl,
    required String token,
    required String since,
    String? resourceType,
    int limit = 1000,
  }) async {
    try {
      final dio = _createClient(
        baseUrl: baseUrl,
        token: token,
      );

      final queryParams = <String, dynamic>{
        'since': since,
        'limit': limit,
      };

      if (resourceType != null) {
        queryParams['resource_type'] =
            resourceType; // Server expects "resource_type" not "resourceType"
      }

      final response = await dio.get(
        '/api/secure/sync/updates',
        queryParameters: queryParams,
      );

      return _responseHandler.handleResponse(
          response, 'Get incremental updates');
    } catch (e) {
      logger.e('❌ Get incremental updates failed: $e');
      rethrow;
    }
  }

  // ===== TOKEN VALIDATION METHODS =====

  /// Check server health (public endpoint, no auth required)
  Future<Map<String, dynamic>> checkServerHealth({
    required String baseUrl,
  }) async {
    try {
      final dio = _createHealthCheckClient(baseUrl: baseUrl);
      final response = await dio.get('/api/health');

      logger.d('✅ Health check successful with $baseUrl');
      return {
        'success': response.statusCode == 200,
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } catch (e) {
      logger.e('❌ Health check failed with $baseUrl: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Test connection to a server using QR configuration
  Future<Map<String, dynamic>> testConnection({
    required String baseUrl,
    required String token,
  }) async {
    try {
      final dio = _createClient(
        baseUrl: baseUrl,
        token: token,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
      );

      final response = await dio.get('/api/health');
      return {
        'success': response.statusCode == 200,
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } catch (e) {
      logger.e('❌ Connection test failed: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Validate token using QR configuration
  Future<Map<String, dynamic>> validateToken({
    required String baseUrl,
    required String token,
    required String endpoint,
  }) async {
    try {
      final dio = _createClient(
        baseUrl: baseUrl,
        token: token,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
      );

      final response = await dio.get(endpoint);
      return {
        'success': response.statusCode == 200,
        'statusCode': response.statusCode,
        'data': response.data,
      };
    } catch (e) {
      logger.e('❌ Token validation failed: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Validate token with detailed response
  Future<Map<String, dynamic>> validateTokenDetailed({
    required String baseUrl,
    required String token,
    required String endpoint,
  }) async {
    try {
      final dio = _createClient(
        baseUrl: baseUrl,
        token: token,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
      );

      final response = await dio.get(endpoint);
      return _responseHandler.handleResponse(response, 'Validate token');
    } catch (e) {
      logger.e('❌ Token validation failed: $e');
      rethrow;
    }
  }

  /// Check if token is expired
  Future<Map<String, dynamic>> isTokenExpired({
    required String baseUrl,
    required String token,
    required String endpoint,
  }) async {
    try {
      final dio = _createClient(
        baseUrl: baseUrl,
        token: token,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
      );

      final response = await dio.get(endpoint);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final expired = data['expired'] ?? false;

        return {
          'success': true,
          'expired': expired,
          'data': data,
        };
      } else {
        return {
          'success': false,
          'expired': true,
          'error': 'Token validation failed with status ${response.statusCode}',
        };
      }
    } catch (e) {
      logger.e('❌ Token expiration check failed: $e');
      return {
        'success': false,
        'expired': true,
        'error': e.toString(),
      };
    }
  }

  // ===== UTILITY METHODS =====

  /// Create a custom HTTP client with specific configuration
  Dio createCustomClient({
    required String baseUrl,
    String? token,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    Map<String, String>? additionalHeaders,
  }) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout ?? const Duration(seconds: 30),
      receiveTimeout: receiveTimeout ?? const Duration(seconds: 30),
      sendTimeout: sendTimeout ?? const Duration(seconds: 30),
      headers: headers,
    ));
  }

  /// Make a generic HTTP request
  Future<Map<String, dynamic>> makeRequest({
    required String baseUrl,
    required String method,
    required String endpoint,
    String? token,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final dio = createCustomClient(
        baseUrl: baseUrl,
        token: token,
        additionalHeaders: headers,
      );

      Response response;
      switch (method.toUpperCase()) {
        case 'GET':
          response = await dio.get(endpoint, queryParameters: queryParameters);
          break;
        case 'POST':
          response = await dio.post(endpoint,
              data: body, queryParameters: queryParameters);
          break;
        case 'PUT':
          response = await dio.put(endpoint,
              data: body, queryParameters: queryParameters);
          break;
        case 'DELETE':
          response = await dio.delete(endpoint,
              data: body, queryParameters: queryParameters);
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      return _responseHandler.handleResponse(
          response, 'Generic $method request');
    } catch (e) {
      logger.e('❌ Generic request failed: $e');
      rethrow;
    }
  }
}
