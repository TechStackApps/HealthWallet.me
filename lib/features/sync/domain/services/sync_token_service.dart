import 'dart:convert';
import 'package:health_wallet/features/sync/domain/entities/sync_token.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SyncTokenService {
  Future<void> saveToken(SyncToken token);
  Future<SyncToken?> getCurrentToken();
  Future<void> revokeToken();
  Future<bool> hasValidToken();
  Future<void> clearExpiredTokens();
  Stream<SyncToken?> get tokenStream;
  Future<SyncToken> createTokenFromSyncData(Map<String, dynamic> data);
}

@Injectable(as: SyncTokenService)
class SyncTokenServiceImpl implements SyncTokenService {
  final SharedPreferences _prefs;
  static const String _tokenKey = 'sync_token';
  static const String _tokenHistoryKey = 'sync_token_history';

  SyncTokenServiceImpl(this._prefs);

  @override
  Future<void> saveToken(SyncToken token) async {
    await _prefs.setString(_tokenKey, jsonEncode(token.toJson()));
    await _addToHistory(token);
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

      return token;
    } catch (e) {
      // If parsing fails, remove invalid token
      await revokeToken();
      return null;
    }
  }

  @override
  Future<void> revokeToken() async {
    await _prefs.remove(_tokenKey);
  }

  @override
  Future<bool> hasValidToken() async {
    final token = await getCurrentToken();
    return token?.isValid ?? false;
  }

  @override
  Future<void> clearExpiredTokens() async {
    final token = await getCurrentToken();
    if (token != null && token.isExpired) {
      await revokeToken();
    }
  }

  @override
  Stream<SyncToken?> get tokenStream async* {
    // Initial value
    yield await getCurrentToken();

    // Listen for changes (simplified - in real implementation you'd use a stream controller)
    // For now, we'll just yield the current token
  }

  Future<void> _addToHistory(SyncToken token) async {
    final historyJson = _prefs.getString(_tokenHistoryKey) ?? '[]';
    final history = jsonDecode(historyJson) as List<dynamic>;

    // Add new token to history
    history.insert(0, {
      'serverName': token.serverName,
      'createdAt': token.createdAt.toIso8601String(),
      'expiresAt': token.expiresAt.toIso8601String(),
      'revokedAt': null,
    });

    // Keep only last 10 entries
    if (history.length > 10) {
      history.removeRange(10, history.length);
    }

    await _prefs.setString(_tokenHistoryKey, jsonEncode(history));
  }

  Future<List<Map<String, dynamic>>> getTokenHistory() async {
    final historyJson = _prefs.getString(_tokenHistoryKey) ?? '[]';
    return (jsonDecode(historyJson) as List<dynamic>)
        .cast<Map<String, dynamic>>();
  }

  Future<SyncToken> createTokenFromSyncData(Map<String, dynamic> data) async {
    final now = DateTime.now();
    final expiresAt =
        now.add(const Duration(hours: 24)); // Default 24 hour expiry

    return SyncToken(
      token: data['token'] as String,
      address: data['address'] as String,
      port: data['port'] as String,
      serverName:
          data['serverName'] as String? ?? '${data['address']}:${data['port']}',
      createdAt: now,
      expiresAt: expiresAt,
      isActive: true,
    );
  }
}
