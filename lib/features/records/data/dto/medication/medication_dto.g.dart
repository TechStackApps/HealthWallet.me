// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MedicationDtoImpl _$$MedicationDtoImplFromJson(Map<String, dynamic> json) =>
    _$MedicationDtoImpl(
      name: json['name'] as String,
      dosage: json['dosage'] as String,
      frequency: json['frequency'] as String,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$MedicationDtoImplToJson(_$MedicationDtoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dosage': instance.dosage,
      'frequency': instance.frequency,
      'reason': instance.reason,
    };
