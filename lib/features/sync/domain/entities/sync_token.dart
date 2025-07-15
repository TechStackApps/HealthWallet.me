import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_token.freezed.dart';
part 'sync_token.g.dart';

@freezed
class SyncToken with _$SyncToken {
  const factory SyncToken({
    required String token,
    required String address,
    required String port,
    required String serverName,
    required DateTime createdAt,
    required DateTime expiresAt,
    @Default(true) bool isActive,
  }) = _SyncToken;

  factory SyncToken.fromJson(Map<String, dynamic> json) =>
      _$SyncTokenFromJson(json);
}

extension SyncTokenExtensions on SyncToken {
  /// Check if the token is expired
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Check if the token is about to expire (within 24 hours)
  bool get isExpiringSoon =>
      DateTime.now().add(const Duration(hours: 24)).isAfter(expiresAt);

  /// Get the full base URL for API calls
  String get baseUrl => 'http://$address:$port/api';

  /// Get time remaining until expiration
  Duration get timeUntilExpiration => expiresAt.difference(DateTime.now());

  /// Check if token is valid and usable
  bool get isValid => isActive && !isExpired;
}
