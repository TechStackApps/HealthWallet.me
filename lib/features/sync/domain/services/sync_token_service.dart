import 'dart:convert';
import 'dart:async';
import 'package:health_wallet/features/sync/domain/entities/sync_token.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_wallet/features/sync/domain/repository/sync_repository.dart';
import 'package:health_wallet/features/sync/domain/entities/connection_status.dart';
import 'package:get_it/get_it.dart';

abstract class SyncTokenService {
  Future<void> saveToken(SyncToken token);
  Future<SyncToken?> getCurrentToken();
  Future<void> revokeToken({String? tokenId});
  Future<bool> hasValidToken();
  Future<void> clearExpiredTokens();
  Stream<SyncToken?> get tokenStream;
  Future<SyncToken> createTokenFromSyncData(Map<String, dynamic> data);

  // Essential token management methods
  Future<List<SyncToken>> getAllTokens();
  Future<void> markTokenAsUsed(String tokenId);
  Future<bool> validateTokenStatus(SyncToken token);
  Future<void> cleanupOldTokens();
  Future<SyncTokenConnectionStatus> getConnectionStatus();
  Future<ConnectionStatus> checkConnectionValidity();

  /// Updates the server address for an existing token when network changes
  Future<void> updateServerAddress(String newAddress, String newPort);

  /// Attempts to reconnect using different network addresses
  Future<bool> attemptReconnection();
}

enum SyncTokenConnectionStatus {
  connected,
  expired,
  noToken,
  connectionError,
}

@Injectable(as: SyncTokenService)
class SyncTokenServiceImpl implements SyncTokenService {
  final SharedPreferences _prefs;
  static const String _tokenKey = 'sync_token';
  static const String _tokenHistoryKey = 'sync_token_history';
  static const String _allTokensKey = 'all_sync_tokens';
  static const int _maxTokenHistory = 10;
  static const int _maxStoredTokens = 5;

  // Stream controller for real-time token updates
  final StreamController<SyncToken?> _tokenController =
      StreamController<SyncToken?>.broadcast();

  SyncTokenServiceImpl(this._prefs) {
    // Initialize with current token on startup
    _initializeTokenStream();
  }

  SyncRepository get _syncRepository => GetIt.instance<SyncRepository>();

  void _initializeTokenStream() async {
    final currentToken = await getCurrentToken();
    _tokenController.add(currentToken);
  }

  @override
  Future<void> saveToken(SyncToken token) async {
    // Save as current token
    await _prefs.setString(_tokenKey, jsonEncode(token.toJson()));

    // Add to token history
    await _addToHistory(token);

    // Add to all tokens list for GitHub-like management
    await _addToAllTokens(token);

    // Clean up old tokens
    await cleanupOldTokens();

    // Notify stream listeners
    _tokenController.add(token);
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
        await revokeToken();
        return null;
      }

      // Validate token status with enhanced checks
      if (!await validateTokenStatus(token)) {
        await revokeToken();
        return null;
      }

      return token;
    } catch (e) {
      // If parsing fails, remove invalid token
      await revokeToken();
      return null;
    }
  }

  @override
  Future<void> revokeToken({String? tokenId}) async {
    if (tokenId != null) {
      // Revoke specific token
      await _revokeSpecificToken(tokenId);
    } else {
      // Revoke current token
      await _prefs.remove(_tokenKey);
      _tokenController.add(null);
    }
  }

  Future<void> _revokeSpecificToken(String tokenId) async {
    // Remove from all tokens list
    final allTokens = await getAllTokens();
    final updatedTokens =
        allTokens.where((token) => token.tokenId != tokenId).toList();
    await _saveAllTokens(updatedTokens);

    // If it's the current token, remove it
    final currentToken = await getCurrentToken();
    if (currentToken?.tokenId == tokenId) {
      await _prefs.remove(_tokenKey);
      _tokenController.add(null);
    }
  }

  @override
  Future<bool> hasValidToken() async {
    final token = await getCurrentToken();
    return token?.isValid ?? false;
  }

  @override
  Future<void> clearExpiredTokens() async {
    final allTokens = await getAllTokens();
    final validTokens = <SyncToken>[];

    for (final token in allTokens) {
      if (!token.isExpired && await validateTokenStatus(token)) {
        validTokens.add(token);
      }
    }

    await _saveAllTokens(validTokens);

    // Check if current token is still valid
    final currentToken = await getCurrentToken();
    if (currentToken != null && currentToken.isExpired) {
      await revokeToken();
    }
  }

  @override
  Stream<SyncToken?> get tokenStream => _tokenController.stream;

  @override
  Future<List<SyncToken>> getAllTokens() async {
    final tokensJson = _prefs.getString(_allTokensKey) ?? '[]';
    try {
      final tokensList = jsonDecode(tokensJson) as List<dynamic>;
      return tokensList
          .map((tokenData) =>
              SyncToken.fromJson(tokenData as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> _saveAllTokens(List<SyncToken> tokens) async {
    final tokensJson = tokens.map((token) => token.toJson()).toList();
    await _prefs.setString(_allTokensKey, jsonEncode(tokensJson));
  }

  Future<void> _addToAllTokens(SyncToken newToken) async {
    final allTokens = await getAllTokens();

    // Remove any existing token with the same ID
    final existingIndex =
        allTokens.indexWhere((token) => token.tokenId == newToken.tokenId);
    if (existingIndex != -1) {
      allTokens.removeAt(existingIndex);
    }

    // Add new token to the beginning
    allTokens.insert(0, newToken);

    // Keep only the most recent tokens
    if (allTokens.length > _maxStoredTokens) {
      allTokens.removeRange(_maxStoredTokens, allTokens.length);
    }

    await _saveAllTokens(allTokens);
  }

  @override
  Future<void> markTokenAsUsed(String tokenId) async {
    final allTokens = await getAllTokens();
    bool updated = false;

    for (int i = 0; i < allTokens.length; i++) {
      if (allTokens[i].tokenId == tokenId) {
        allTokens[i] = allTokens[i].copyWith(lastUsedAt: DateTime.now());
        updated = true;
        break;
      }
    }

    if (updated) {
      await _saveAllTokens(allTokens);

      // Update current token if it matches
      final currentToken = await getCurrentToken();
      if (currentToken?.tokenId == tokenId) {
        final updatedCurrentToken =
            currentToken!.copyWith(lastUsedAt: DateTime.now());
        await _prefs.setString(
            _tokenKey, jsonEncode(updatedCurrentToken.toJson()));
        _tokenController.add(updatedCurrentToken);
      }
    }
  }

  @override
  Future<bool> validateTokenStatus(SyncToken token) async {
    // Basic validation checks
    if (token.isExpired || !token.isActive) {
      return false;
    }

    // Additional validation could include:
    // - Network connectivity check
    // - Server reachability test
    // - Token validation against server

    return true;
  }

  @override
  Future<void> cleanupOldTokens() async {
    // Remove expired tokens
    await clearExpiredTokens();

    // Clean up old history entries
    final historyJson = _prefs.getString(_tokenHistoryKey) ?? '[]';
    try {
      final history = jsonDecode(historyJson) as List<dynamic>;
      if (history.length > _maxTokenHistory) {
        final trimmedHistory = history.take(_maxTokenHistory).toList();
        await _prefs.setString(_tokenHistoryKey, jsonEncode(trimmedHistory));
      }
    } catch (e) {
      // If history is corrupted, reset it
      await _prefs.setString(_tokenHistoryKey, '[]');
    }
  }

  @override
  Future<SyncTokenConnectionStatus> getConnectionStatus() async {
    final currentToken = await getCurrentToken();

    if (currentToken == null) {
      return SyncTokenConnectionStatus.noToken;
    }

    if (currentToken.isExpired) {
      return SyncTokenConnectionStatus.expired;
    }

    // Could add network/server connectivity check here
    try {
      final isValid = await validateTokenStatus(currentToken);
      return isValid
          ? SyncTokenConnectionStatus.connected
          : SyncTokenConnectionStatus.connectionError;
    } catch (e) {
      return SyncTokenConnectionStatus.connectionError;
    }
  }

  @override
  Future<ConnectionStatus> checkConnectionValidity() async {
    try {
      return await _syncRepository.checkConnectionValidity();
    } catch (_) {
      return ConnectionStatus.serverDown;
    }
  }

  /// Updates the server address for an existing token when network changes
  @override
  Future<void> updateServerAddress(String newAddress, String newPort) async {
    final currentToken = await getCurrentToken();
    if (currentToken != null) {
      final updatedToken = currentToken.copyWith(
        address: newAddress,
        port: newPort,
        serverName: '$newAddress:$newPort',
      );
      await saveToken(updatedToken);
      // logger.i('Updated server address to $newAddress:$newPort'); // logger is not defined in this file
    }
  }

  /// Attempts to reconnect using different network addresses
  @override
  Future<bool> attemptReconnection() async {
    final currentToken = await getCurrentToken();
    if (currentToken == null) return false;

    // Use fallback addresses from token if available
    final addressesToTry = currentToken.hasFallbackAddresses
        ? currentToken.allAddresses
        : [
            'localhost',
            '127.0.0.1',
          ];

    for (final address in addressesToTry) {
      try {
        // Extract host and port from address
        final parts = address.split(':');
        final host = parts[0];
        final port = parts.length > 1 ? parts[1] : currentToken.port;

        await updateServerAddress(host, port);
        final status = await checkConnectionValidity();
        if (status == ConnectionStatus.valid) {
          return true;
        }
      } catch (e) {
        // Continue to next address
      }
    }

    return false;
  }

  Future<void> _addToHistory(SyncToken token) async {
    final historyJson = _prefs.getString(_tokenHistoryKey) ?? '[]';
    final history = jsonDecode(historyJson) as List<dynamic>;

    // Add new token to history
    history.insert(0, {
      'serverName': token.serverName,
      'tokenId': token.tokenId,
      'createdAt': token.createdAt.toIso8601String(),
      'expiresAt': token.expiresAt.toIso8601String(),
      'revokedAt': null,
      'lastUsedAt': token.lastUsedAt?.toIso8601String(),
    });

    // Keep only last _maxTokenHistory entries
    if (history.length > _maxTokenHistory) {
      history.removeRange(_maxTokenHistory, history.length);
    }

    await _prefs.setString(_tokenHistoryKey, jsonEncode(history));
  }

  Future<List<Map<String, dynamic>>> getTokenHistory() async {
    final historyJson = _prefs.getString(_tokenHistoryKey) ?? '[]';
    return (jsonDecode(historyJson) as List<dynamic>)
        .cast<Map<String, dynamic>>();
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

    // Legacy format with server object
    if (data.containsKey('server')) {
      final server = data['server'] as Map<String, dynamic>;
      if (server.containsKey('host')) {
        address = server['host'] as String;
      }
      if (server.containsKey('port')) {
        port = server['port'] as String;
      }
    }

    // Extract fallback addresses for network resilience
    List<String> fallbackAddresses = [];

    // New format with addresses array
    if (data.containsKey('addresses')) {
      final addresses = data['addresses'] as List<dynamic>;
      fallbackAddresses = addresses
          .where((addr) => addr != '$address:$port')
          .map((addr) => addr.toString())
          .toList();
    }

    // Simple fallback addresses
    if (fallbackAddresses.isEmpty) {
      if (address == 'localhost' || address == '127.0.0.1') {
        fallbackAddresses = [
          '192.168.1.1:$port',
        ];
      } else {
        fallbackAddresses = [
          'localhost:$port',
        ];
      }

      // Replace $port placeholder with actual port
      fallbackAddresses = fallbackAddresses
          .map((addr) => addr.replaceAll('\$port', port))
          .toList();
    }

    // Extract server info
    Map<String, dynamic> serverInfo = {};
    if (data.containsKey('serverInfo')) {
      serverInfo = Map<String, dynamic>.from(data['serverInfo'] as Map);
    } else if (data.containsKey('app')) {
      // Legacy format - extract from app info
      final app = data['app'] as Map<String, dynamic>;
      serverInfo = {
        'name': app['name'] ?? 'Health Wallet',
        'version': app['version'] ?? '1.0.0',
      };
    }

    return SyncToken(
      token: data['token'] as String,
      address: address,
      port: port,
      serverName: '$address:$port',
      createdAt: data.containsKey('createdAt')
          ? DateTime.parse(data['createdAt'] as String)
          : now,
      expiresAt: expiresAt,
      isActive: true,
      tokenId: tokenId,
      lastUsedAt: null,
      fallbackAddresses: fallbackAddresses,
      serverInfo: serverInfo,
    );
  }

  void dispose() {
    _tokenController.close();
  }
}
