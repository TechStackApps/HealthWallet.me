import 'package:injectable/injectable.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_token.dart';
import 'package:health_wallet/features/sync/domain/services/token_service.dart';
import 'package:health_wallet/features/sync/domain/services/sync_retry_service.dart';
import 'package:health_wallet/features/sync/domain/services/sync_error_handler.dart';
import 'package:health_wallet/core/utils/logger.dart';

/// Result of token validation operation
class TokenValidationResult {
  final bool isValid;
  final bool isExpired;
  final String? errorMessage;
  final Map<String, dynamic>? serverInfo;
  final DateTime? expirationTime;

  const TokenValidationResult({
    required this.isValid,
    required this.isExpired,
    this.errorMessage,
    this.serverInfo,
    this.expirationTime,
  });

  bool get canConnect => isValid && !isExpired;
  
  String get statusDescription {
    if (isValid && !isExpired) return 'Valid';
    if (isExpired) return 'Expired';
    if (!isValid) return 'Invalid';
    return 'Unknown';
  }
}

/// Use case for validating sync tokens and server connectivity
@injectable
class ValidateTokenUseCase {
  final TokenService _tokenService;
  final SyncRetryService _retryService;
  final SyncErrorHandler _errorHandler;

  ValidateTokenUseCase(
    this._tokenService,
    this._retryService,
    this._errorHandler,
  );

  /// Validate a sync token and check server connectivity
  Future<TokenValidationResult> execute({
    required SyncToken token,
    required String baseUrl,
    bool checkServerHealth = true,
    bool fetchServerInfo = false,
  }) async {
    return _retryService.executeWithRetry(
      'token_validation',
      () async {
        try {
          logger.i('🔍 Validating token and server connectivity');
          
          // Step 1: Check server health (if requested)
          if (checkServerHealth) {
            final isHealthy = await _checkServerHealth(baseUrl);
            if (!isHealthy) {
              return const TokenValidationResult(
                isValid: false,
                isExpired: false,
                errorMessage: 'Server is not accessible or not responding',
              );
            }
          }

          // Step 2: Validate token
          final tokenValid = await _validateToken(token, baseUrl);
          if (!tokenValid) {
            return const TokenValidationResult(
              isValid: false,
              isExpired: false,
              errorMessage: 'Token validation failed',
            );
          }

          // Step 3: Check if token is expired
          final isExpired = await _checkTokenExpiration(token, baseUrl);
          
          // Step 4: Fetch additional server info (if requested)
          Map<String, dynamic>? serverInfo;
          if (fetchServerInfo && !isExpired) {
            serverInfo = await _fetchServerInfo(token, baseUrl);
          }

          logger.i('✅ Token validation completed successfully');
          
          return TokenValidationResult(
            isValid: true,
            isExpired: isExpired,
            serverInfo: serverInfo,
          );
          
        } catch (e, stackTrace) {
          final syncException = _errorHandler.handleError(
            e,
            operation: 'token_validation',
            context: {
              'baseUrl': baseUrl,
              'tokenId': token.tokenId,
            },
          );
          
          _errorHandler.logError(syncException, stackTrace: stackTrace);
          
          return TokenValidationResult(
            isValid: false,
            isExpired: false,
            errorMessage: _errorHandler.getUserFriendlyMessage(syncException),
          );
        }
      },
      policy: const RetryPolicy(
        maxAttempts: 2,
        initialDelay: Duration(seconds: 3),
        maxDelay: Duration(seconds: 15),
        retryableErrorCodes: [
          'CONNECTION_TIMEOUT',
          'NETWORK_ERROR',
          'CONNECTION_ERROR',
        ],
      ),
      context: {
        'use_case': 'token_validation',
        'baseUrl': baseUrl,
      },
    );
  }

  /// Perform comprehensive token and connectivity check
  Future<Map<String, dynamic>> performComprehensiveCheck({
    required SyncToken token,
    required String baseUrl,
  }) async {
    final results = <String, dynamic>{
      'timestamp': DateTime.now().toIso8601String(),
      'baseUrl': baseUrl,
      'tokenId': token.tokenId,
    };

    try {
      // Test server health
      logger.d('🏥 Testing server health...');
      final healthCheckStart = DateTime.now();
      final isHealthy = await _checkServerHealth(baseUrl);
      final healthCheckDuration = DateTime.now().difference(healthCheckStart);
      
      results['serverHealth'] = {
        'isHealthy': isHealthy,
        'responseTime': healthCheckDuration.inMilliseconds,
        'status': isHealthy ? 'online' : 'offline',
      };

      if (!isHealthy) {
        results['overallStatus'] = 'server_unreachable';
        return results;
      }

      // Test token validation
      logger.d('🔑 Testing token validation...');
      final tokenValidStart = DateTime.now();
      final tokenValid = await _validateToken(token, baseUrl);
      final tokenValidDuration = DateTime.now().difference(tokenValidStart);
      
      results['tokenValidation'] = {
        'isValid': tokenValid,
        'responseTime': tokenValidDuration.inMilliseconds,
      };

      if (!tokenValid) {
        results['overallStatus'] = 'token_invalid';
        return results;
      }

      // Check token expiration
      logger.d('⏰ Checking token expiration...');
      final isExpired = await _checkTokenExpiration(token, baseUrl);
      results['tokenExpiration'] = {
        'isExpired': isExpired,
        'status': isExpired ? 'expired' : 'valid',
      };

      if (isExpired) {
        results['overallStatus'] = 'token_expired';
        return results;
      }

      // Test endpoints availability
      logger.d('🔗 Testing endpoint availability...');
      final endpointTests = await _testEndpoints(token, baseUrl);
      results['endpoints'] = endpointTests;

      // Overall status
      final allEndpointsWorking = endpointTests.values
          .every((test) => test['available'] == true);
      
      results['overallStatus'] = allEndpointsWorking ? 'fully_operational' : 'partial_functionality';
      
      logger.i('✅ Comprehensive check completed');
      return results;
      
    } catch (e, stackTrace) {
      final syncException = _errorHandler.handleError(
        e,
        operation: 'comprehensive_check',
        context: {'baseUrl': baseUrl, 'tokenId': token.tokenId},
      );
      
      _errorHandler.logError(syncException, stackTrace: stackTrace);
      
      results['overallStatus'] = 'error';
      results['error'] = _errorHandler.getUserFriendlyMessage(syncException);
      return results;
    }
  }

  /// Check server health
  Future<bool> _checkServerHealth(String baseUrl) async {
    try {
      return await _tokenService.checkServerHealth(baseUrl: baseUrl);
    } catch (e) {
      logger.e('❌ Server health check failed: $e');
      return false;
    }
  }

  /// Validate token
  Future<bool> _validateToken(SyncToken token, String baseUrl) async {
    try {
      final endpoint = token.endpoints['accessTokens'] ?? '/api/secure/sync/discovery';
      return await _tokenService.validateToken(
        baseUrl: baseUrl,
        token: token.token,
        endpoint: endpoint,
      );
    } catch (e) {
      logger.e('❌ Token validation failed: $e');
      return false;
    }
  }

  /// Check if token is expired
  Future<bool> _checkTokenExpiration(SyncToken token, String baseUrl) async {
    try {
      final endpoint = token.endpoints['accessTokens'] ?? '/api/secure/sync/discovery';
      return await _tokenService.isTokenExpired(
        baseUrl: baseUrl,
        token: token.token,
        endpoint: endpoint,
      );
    } catch (e) {
      logger.e('❌ Token expiration check failed: $e');
      return true; // Assume expired if we can't check
    }
  }

  /// Fetch additional server information
  Future<Map<String, dynamic>?> _fetchServerInfo(SyncToken token, String baseUrl) async {
    try {
      final endpoint = token.endpoints['accessTokens'] ?? '/api/secure/sync/discovery';
      return await _tokenService.validateTokenDetailed(
        baseUrl: baseUrl,
        token: token.token,
        endpoint: endpoint,
      );
    } catch (e) {
      logger.w('⚠️ Failed to fetch server info: $e');
      return null;
    }
  }

  /// Test individual endpoints
  Future<Map<String, Map<String, dynamic>>> _testEndpoints(
    SyncToken token,
    String baseUrl,
  ) async {
    final results = <String, Map<String, dynamic>>{};
    
    final endpointsToTest = [
      {'name': 'discovery', 'path': token.endpoints['accessTokens'] ?? '/api/secure/sync/discovery'},
      {'name': 'status', 'path': '/api/secure/sync/status'},
      {'name': 'updates', 'path': '/api/secure/sync/updates'},
    ];

    for (final endpoint in endpointsToTest) {
      final name = endpoint['name'] as String;
      final path = endpoint['path'] as String;
      
      try {
        final start = DateTime.now();
        final isAvailable = await _tokenService.validateToken(
          baseUrl: baseUrl,
          token: token.token,
          endpoint: path,
        );
        final duration = DateTime.now().difference(start);
        
        results[name] = {
          'available': isAvailable,
          'responseTime': duration.inMilliseconds,
          'path': path,
        };
      } catch (e) {
        results[name] = {
          'available': false,
          'error': e.toString(),
          'path': path,
        };
      }
    }
    
    return results;
  }

  /// Get token health score (0-100)
  int getTokenHealthScore(TokenValidationResult result) {
    if (!result.isValid) return 0;
    if (result.isExpired) return 25;
    if (result.errorMessage != null) return 50;
    
    int score = 75; // Base score for valid, non-expired token
    
    // Bonus points for server info availability
    if (result.serverInfo != null) {
      score += 25;
    }
    
    return score.clamp(0, 100);
  }
}
