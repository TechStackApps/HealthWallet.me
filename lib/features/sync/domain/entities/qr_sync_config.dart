import 'package:freezed_annotation/freezed_annotation.dart';

part 'qr_sync_config.freezed.dart';
part 'qr_sync_config.g.dart';

/// QR Code Sync Configuration Entity
@freezed
class QRSyncConfig with _$QRSyncConfig {
  const factory QRSyncConfig({
    required String token,
    required List<Connection> connections,
    required Endpoints endpoints,
    @JsonKey(name: 'expiresAt') DateTime? expiresAt,
  }) = _QRSyncConfig;

  factory QRSyncConfig.fromJson(Map<String, dynamic> json) =>
      _$QRSyncConfigFromJson(json);
}

@freezed
class Connection with _$Connection {
  const factory Connection({
    required String host,
    required String port,
    required String protocol,
  }) = _Connection;

  factory Connection.fromJson(Map<String, dynamic> json) =>
      _$ConnectionFromJson(json);
}

@freezed
class ServerInfo with _$ServerInfo {
  const factory ServerInfo({
    required String host,
    required String port,
    required String protocol,
  }) = _ServerInfo;

  factory ServerInfo.fromJson(Map<String, dynamic> json) =>
      _$ServerInfoFromJson(json);
}

@freezed
class Endpoints with _$Endpoints {
  const factory Endpoints({
    @JsonKey(name: 'access_tokens') required String accessTokens,
    @JsonKey(name: 'sync_data') required String syncData,
    @JsonKey(name: 'sync_updates') required String syncUpdates,
  }) = _Endpoints;

  factory Endpoints.fromJson(Map<String, dynamic> json) =>
      _$EndpointsFromJson(json);
}

extension QRSyncConfigExtensions on QRSyncConfig {
  Connection get primaryConnection => connections.first;

  String get baseUrl =>
      '${primaryConnection.protocol}://${primaryConnection.host}:${primaryConnection.port}';

  String get accessTokensUrl => '$baseUrl${endpoints.accessTokens}';

  String get syncDataUrl => '$baseUrl${endpoints.syncData}';

  String get syncUpdatesUrl => '$baseUrl${endpoints.syncUpdates}';

  bool get isExpired =>
      expiresAt != null ? DateTime.now().isAfter(expiresAt!) : false;

  bool get isValid => token.isNotEmpty && connections.isNotEmpty && !isExpired;

  Duration? get timeUntilExpiration => expiresAt?.difference(DateTime.now());

  String get expirationStatus {
    if (expiresAt == null) return 'No expiration';
    if (isExpired) return 'Expired';
    final duration = timeUntilExpiration!;
    if (duration.inDays > 0) {
      return 'Expires in ${duration.inDays} days';
    } else if (duration.inHours > 0) {
      return 'Expires in ${duration.inHours} hours';
    } else if (duration.inMinutes > 0) {
      return 'Expires in ${duration.inMinutes} minutes';
    } else {
      return 'Expires soon';
    }
  }

  List<String> get allBaseUrls => connections
      .map((connection) =>
          '${connection.protocol}://${connection.host}:${connection.port}')
      .toList();

  String getBaseUrlForConnection(int index) {
    if (index >= 0 && index < connections.length) {
      final connection = connections[index];
      return '${connection.protocol}://${connection.host}:${connection.port}';
    }
    return baseUrl;
  }

  String getAccessTokensUrlForConnection(int index) =>
      '${getBaseUrlForConnection(index)}${endpoints.accessTokens}';

  String getSyncDataUrlForConnection(int index) =>
      '${getBaseUrlForConnection(index)}${endpoints.syncData}';

  String getSyncUpdatesUrlForConnection(int index) =>
      '${getBaseUrlForConnection(index)}${endpoints.syncUpdates}';
}
