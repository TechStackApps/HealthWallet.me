// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceImpl _$$DeviceImplFromJson(Map<String, dynamic> json) => _$DeviceImpl(
      id: json['id'] as String?,
      code: json['code'] == null
          ? null
          : CodeableConcept.fromJson(json['code'] as Map<String, dynamic>),
      model: json['model'] as String?,
      status: json['status'] as String?,
      hasExpiry: json['has_expiry'] as bool?,
      getExpiry: json['get_expiry'] as String?,
      getTypeCoding: (json['get_type_coding'] as List<dynamic>?)
          ?.map((e) => Coding.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasTypeCoding: json['has_type_coding'] as bool?,
      getUdi: json['get_udi'] as String?,
      udiCarrierAidc: json['udi_carrier_aidc'] as String?,
      udiCarrierHrf: json['udi_carrier_hrf'] as String?,
      safety: json['safety'] as String?,
      hasSafety: json['has_safety'] as bool?,
    );

Map<String, dynamic> _$$DeviceImplToJson(_$DeviceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'model': instance.model,
      'status': instance.status,
      'has_expiry': instance.hasExpiry,
      'get_expiry': instance.getExpiry,
      'get_type_coding': instance.getTypeCoding,
      'has_type_coding': instance.hasTypeCoding,
      'get_udi': instance.getUdi,
      'udi_carrier_aidc': instance.udiCarrierAidc,
      'udi_carrier_hrf': instance.udiCarrierHrf,
      'safety': instance.safety,
      'has_safety': instance.hasSafety,
    };
