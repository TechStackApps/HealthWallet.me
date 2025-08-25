import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_wallet/features/sync/domain/entities/sync_token.dart';
import 'package:health_wallet/features/sync/data/data_source/remote/remote_sync_service.dart';
import 'package:health_wallet/core/utils/logger.dart';

abstract class TokenService {
  Future<void> saveToken(SyncToken token);
  Future<SyncToken?> getCurrentToken();
  Future<void> clearToken();
  Future<bool> hasValidToken();
  Future<SyncToken> createTokenFromSyncData(Map<String, dynamic> data);
  
  // Token validation methods
  Future<bool> checkServerHealth({required String baseUrl});
  Future<bool> testConnection({required String baseUrl, required String token});
  Future<bool> validateToken({required String baseUrl, required String token, required String endpoint});
  Future<Map<String, dynamic>> validateTokenDetailed({required String baseUrl, required String token, required String endpoint});
  Future<bool> isTokenExpired({required String baseUrl, required String token, required String endpoint});
}

@Injectable(as: TokenService)
class TokenServiceImpl implements TokenService {
  final SharedPreferences _prefs;
  final RemoteSyncService _remoteService;
  
  static const String _tokenKey = 'sync_token';

  TokenServiceImpl(this._prefs, this._remoteService);

  // ===== TOKEN MANAGEMENT METHODS =====

  @override
  Future<void> saveToken(SyncToken token) async {
    await _prefs.setString(_tokenKey, jsonEncode(token.toJson()));
  }

  @override
  Future<SyncToken?> getCurrentToken() async {
    final tokenJson = _prefs.getString(_tokenKey);
    if (tokenJson == null) return null;

    try {
      final tokenData = jsonDecode(tokenJson) as Map<String, dynamic>;
      final token = SyncToken.fromJson(tokenData);

      // Check if token is expired
      if (token.isExpired) {
        await clearToken();
        return null;
      }

      return token;
    } catch (e) {
      // If parsing fails, remove invalid token
      await clearToken();
      return null;
    }
  }

  @override
  Future<void> clearToken() async {
    await _prefs.remove(_tokenKey);
  }

  @override
  Future<bool> hasValidToken() async {
    final token = await getCurrentToken();
    return token?.isValid ?? false;
  }

  @override
  Future<SyncToken> createTokenFromSyncData(Map<String, dynamic> data) async {
    final now = DateTime.now();

    // Extract expiration from server response or use default
    DateTime expiresAt;
    if (data.containsKey('expiresAt')) {
      expiresAt = DateTime.parse(data['expiresAt'] as String);
    } else {
      expiresAt = now.add(const Duration(hours: 24)); // Default 24 hour expiry
    }

    // Extract token ID from server response or generate one
    String tokenId;
    if (data.containsKey('tokenId')) {
      tokenId = data['tokenId'] as String;
    } else {
      tokenId = 'token_${now.millisecondsSinceEpoch}';
    }

    // Handle address - support both new and legacy formats
    String address = 'localhost'; // Default address
    String port = '8080'; // Default port

    // New format with explicit address and port
    if (data.containsKey('address')) {
      address = data['address'] as String;
    }
    if (data.containsKey('port')) {
      port = data['port'] as String;
    }

    // Handle server field - can be either a string (address:port) or a map
    if (data.containsKey('server')) {
      final server = data['server'];
      if (server is String) {
        // Server is a string like "192.168.1.164:9090"
        final parts = server.split(':');
        if (parts.length == 2) {
          address = parts[0];
          port = parts[1];
        }
      } else if (server is Map<String, dynamic>) {
        // Server is a map with address and port
        if (server.containsKey('address')) {
          address = server['address'] as String;
        }
        if (server.containsKey('port')) {
          port = server['port'] as String;
        }
      }
    }

    // Extract the actual token value
    String tokenValue;
    if (data.containsKey('token')) {
      tokenValue = data['token'] as String;
    } else if (data.containsKey('accessToken')) {
      tokenValue = data['accessToken'] as String;
    } else {
      throw Exception('No token value found in sync data');
    }

    // Create the base URL
    final baseUrl = 'http://$address:$port';

    return SyncToken(
      token: tokenValue,
      address: address,
      port: port,
      serverName: '$address:$port',
      tokenId: tokenId,
      createdAt: now,
      expiresAt: expiresAt,
    );
  }

  // ===== TOKEN VALIDATION METHODS =====

  @override
  Future<bool> checkServerHealth({required String baseUrl}) async {
    try {
      final response = await _remoteService.checkServerHealth(baseUrl: baseUrl);
      logger.d('✅ Health check successful with $baseUrl');
      return response['success'] == true;
    } catch (e) {
      logger.e('❌ Health check failed with $baseUrl: $e');
      return false;
    }
  }

  @override
  Future<bool> testConnection({required String baseUrl, required String token}) async {
    try {
      final response = await _remoteService.testConnection(
        baseUrl: baseUrl,
        token: token,
      );
      return response['success'] == true;
    } catch (e) {
      logger.e('❌ Connection test failed: $e');
      return false;
    }
  }

  @override
  Future<bool> validateToken({required String baseUrl, required String token, required String endpoint}) async {
    try {
      final response = await _remoteService.validateToken(
        baseUrl: baseUrl,
        token: token,
        endpoint: endpoint,
      );
      return response['success'] == true;
    } catch (e) {
      logger.e('❌ Token validation failed: $e');
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>> validateTokenDetailed({required String baseUrl, required String token, required String endpoint}) async {
    try {
      return await _remoteService.validateTokenDetailed(
        baseUrl: baseUrl,
        token: token,
        endpoint: endpoint,
      );
    } catch (e) {
      logger.e('❌ Token validation failed: $e');
      rethrow;
    }
  }

  @override
  Future<bool> isTokenExpired({required String baseUrl, required String token, required String endpoint}) async {
    try {
      final response = await _remoteService.validateTokenDetailed(
        baseUrl: baseUrl,
        token: token,
        endpoint: endpoint,
      );
      
      if (response['success'] == true && response['data'] != null) {
        final data = response['data'] as Map<String, dynamic>;
        
        // Check if server indicates token is expired
        if (data.containsKey('expired')) {
          return data['expired'] as bool;
        }
        
        // Check if server provides expiration time
        if (data.containsKey('expiresAt')) {
          final expiresAt = DateTime.parse(data['expiresAt'] as String);
          return DateTime.now().isAfter(expiresAt);
        }
        
        // If no expiration info from server, check local token
        final localToken = await getCurrentToken();
        return localToken?.isExpired ?? true;
      }
      
      return true; // Assume expired if validation fails
    } catch (e) {
      logger.e('❌ Failed to check token expiration: $e');
      return true; // Assume expired on error
    }
  }

  // ===== UTILITY METHODS =====

  /// Refresh token if it's close to expiring
  Future<bool> shouldRefreshToken() async {
    final token = await getCurrentToken();
    if (token == null) return false;

    // Refresh if token expires within the next hour
    final oneHourFromNow = DateTime.now().add(const Duration(hours: 1));
    return token.expiresAt.isBefore(oneHourFromNow);
  }

  /// Get token age in hours
  Future<double> getTokenAge() async {
    final token = await getCurrentToken();
    if (token == null) return 0.0;

    final age = DateTime.now().difference(token.createdAt);
    return age.inMinutes / 60.0;
  }

  /// Check if token is still valid for a specific operation
  Future<bool> isTokenValidForOperation(String operation) async {
    final token = await getCurrentToken();
    if (token == null || !token.isValid) return false;

    // Add operation-specific validation logic here if needed
    // For now, just check basic validity
    return true;
  }
}
