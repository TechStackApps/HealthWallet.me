// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ObservationImpl _$$ObservationImplFromJson(Map<String, dynamic> json) =>
    _$ObservationImpl(
      id: json['id'] as String,
      status: json['status'] as String,
      code: CodeableConcept.fromJson(json['code'] as Map<String, dynamic>),
      valueQuantity: json['valueQuantity'] == null
          ? null
          : ValueQuantity.fromJson(
              json['valueQuantity'] as Map<String, dynamic>),
      effectiveDateTime: json['effectiveDateTime'] == null
          ? null
          : DateTime.parse(json['effectiveDateTime'] as String),
    );

Map<String, dynamic> _$$ObservationImplToJson(_$ObservationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'code': instance.code,
      'valueQuantity': instance.valueQuantity,
      'effectiveDateTime': instance.effectiveDateTime?.toIso8601String(),
    };

_$ValueQuantityImpl _$$ValueQuantityImplFromJson(Map<String, dynamic> json) =>
    _$ValueQuantityImpl(
      value: (json['value'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$$ValueQuantityImplToJson(_$ValueQuantityImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'unit': instance.unit,
    };
