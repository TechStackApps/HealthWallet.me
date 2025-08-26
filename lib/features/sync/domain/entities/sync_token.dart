import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_token.freezed.dart';
part 'sync_token.g.dart';

@freezed
class SyncToken with _$SyncToken {
  const factory SyncToken({
    required String token,
    required List<String> serverBaseUrls,
    required DateTime createdAt,
    required DateTime expiresAt,
    @Default(true) bool isActive,
    // Enhanced fields for GitHub-like token management
    required String tokenId,
    DateTime? lastUsedAt,
    // Network resilience fields
    @Default({}) Map<String, dynamic> serverInfo,
    // Protocol and endpoints support (unified from QRSyncConfig)
    @Default({
      'accessTokens': '/api/secure/access/tokens',
      'syncData': '/api/secure/sync/data',
      'syncUpdates': '/api/secure/sync/updates'
    })
    Map<String, String> endpoints,
  }) = _SyncToken;

  factory SyncToken.fromJson(Map<String, dynamic> json) =>
      _$SyncTokenFromJson(json);

  /// Create SyncToken from QR code data (replaces QRSyncConfig.fromJson)
  factory SyncToken.fromQRData(Map<String, dynamic> qrData) {
    final now = DateTime.now();

    // Extract connections array (new format)
    final endpoints = qrData['endpoints'] as Map<String, dynamic>;

    return SyncToken(
      token: qrData['token'] as String,
      serverBaseUrls:
          (qrData["server_base_urls"] as List).whereType<String>().toList(),
      createdAt: now,
      expiresAt: qrData['expiresAt'] != null
          ? DateTime.parse(qrData['expiresAt'] as String)
          : now.add(const Duration(hours: 24)), // Default 24h if no expiration
      tokenId: 'qr_${now.millisecondsSinceEpoch}',
      endpoints: {
        'accessTokens': endpoints['access_tokens'] as String,
        'syncData': endpoints['sync_data'] as String,
        'syncUpdates': endpoints['sync_updates'] as String,
      },
    );
  }
}

extension SyncTokenExtensions on SyncToken {
  /// Check if the token is expired
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Check if the token is about to expire (within 24 hours)
  bool get isExpiringSoon =>
      DateTime.now().add(const Duration(hours: 24)).isAfter(expiresAt);

  /// Check if the token is about to expire within specified duration
  bool isExpiringWithin(Duration duration) =>
      DateTime.now().add(duration).isAfter(expiresAt);

  /// Get time remaining until expiration
  Duration get timeUntilExpiration => expiresAt.difference(DateTime.now());

  /// Check if token is valid and usable
  bool get isValid => isActive && !isExpired;

  /// Get a user-friendly status description
  String get statusDescription {
    if (!isActive) return 'Inactive';
    if (isExpired) return 'Expired';
    if (isExpiringSoon) return 'Expiring Soon';
    return 'Active';
  }

  /// Get connection quality indicator
  String get connectionQuality {
    if (lastUsedAt == null) return 'Unknown';
    final daysSinceLastUse = DateTime.now().difference(lastUsedAt!).inDays;
    if (daysSinceLastUse == 0) return 'Excellent';
    if (daysSinceLastUse <= 7) return 'Good';
    if (daysSinceLastUse <= 30) return 'Fair';
    return 'Poor';
  }

  /// Get connection quality as enum for UI display
  SyncTokenQuality get quality {
    if (lastUsedAt == null) return SyncTokenQuality.invalid;
    if (!isValid) return SyncTokenQuality.invalid;

    final daysSinceLastUse = DateTime.now().difference(lastUsedAt!).inDays;
    if (daysSinceLastUse == 0) return SyncTokenQuality.excellent;
    if (daysSinceLastUse <= 7) return SyncTokenQuality.good;
    if (daysSinceLastUse <= 30) return SyncTokenQuality.fair;
    if (daysSinceLastUse <= 90) return SyncTokenQuality.poor;
    return SyncTokenQuality.critical;
  }

  /// Check if token was recently used (within last hour)
  bool get wasRecentlyUsed {
    if (lastUsedAt == null) return false;
    return DateTime.now().difference(lastUsedAt!).inHours < 1;
  }

  /// Get time since last use
  Duration? get timeSinceLastUse {
    if (lastUsedAt == null) return null;
    return DateTime.now().difference(lastUsedAt!);
  }

  /// Get a short identifier for display purposes
  String get shortId =>
      tokenId.length > 8 ? '${tokenId.substring(0, 8)}...' : tokenId;

  /// Get formatted expiration time for display
  String get formattedExpiration {
    final now = DateTime.now();
    final diff = expiresAt.difference(now);

    if (diff.isNegative) {
      final expiredDiff = now.difference(expiresAt);
      if (expiredDiff.inDays > 0) {
        return 'Expired ${expiredDiff.inDays} day${expiredDiff.inDays != 1 ? 's' : ''} ago';
      } else if (expiredDiff.inHours > 0) {
        return 'Expired ${expiredDiff.inHours} hour${expiredDiff.inHours != 1 ? 's' : ''} ago';
      } else {
        return 'Expired ${expiredDiff.inMinutes} minute${expiredDiff.inMinutes != 1 ? 's' : ''} ago';
      }
    } else {
      if (diff.inDays > 0) {
        return 'Expires in ${diff.inDays} day${diff.inDays != 1 ? 's' : ''}';
      } else if (diff.inHours > 0) {
        return 'Expires in ${diff.inHours} hour${diff.inHours != 1 ? 's' : ''}';
      } else {
        return 'Expires in ${diff.inMinutes} minute${diff.inMinutes != 1 ? 's' : ''}';
      }
    }
  }

  /// Get formatted last used time for display
  String? get formattedLastUsed {
    if (lastUsedAt == null) return null;

    final now = DateTime.now();
    final diff = now.difference(lastUsedAt!);

    if (diff.inDays > 0) {
      return '${diff.inDays} day${diff.inDays != 1 ? 's' : ''} ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hour${diff.inHours != 1 ? 's' : ''} ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} minute${diff.inMinutes != 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}

enum SyncTokenQuality {
  excellent,
  good,
  fair,
  poor,
  critical,
  invalid,
}
