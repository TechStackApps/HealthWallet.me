// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SyncTokenImpl _$$SyncTokenImplFromJson(Map<String, dynamic> json) =>
    _$SyncTokenImpl(
      token: json['token'] as String,
      address: json['address'] as String,
      port: json['port'] as String,
      serverName: json['serverName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      isActive: json['isActive'] as bool? ?? true,
      tokenId: json['tokenId'] as String,
      lastUsedAt: json['lastUsedAt'] == null
          ? null
          : DateTime.parse(json['lastUsedAt'] as String),
      fallbackAddresses: (json['fallbackAddresses'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      serverInfo: json['serverInfo'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$SyncTokenImplToJson(_$SyncTokenImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'address': instance.address,
      'port': instance.port,
      'serverName': instance.serverName,
      'createdAt': instance.createdAt.toIso8601String(),
      'expiresAt': instance.expiresAt.toIso8601String(),
      'isActive': instance.isActive,
      'tokenId': instance.tokenId,
      'lastUsedAt': instance.lastUsedAt?.toIso8601String(),
      'fallbackAddresses': instance.fallbackAddresses,
      'serverInfo': instance.serverInfo,
    };
