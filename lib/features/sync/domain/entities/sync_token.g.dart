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
    };
