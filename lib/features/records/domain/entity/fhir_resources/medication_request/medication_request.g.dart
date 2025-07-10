// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MedicationRequestImpl _$$MedicationRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$MedicationRequestImpl(
      id: json['id'] as String,
      status: json['status'] as String,
      intent: json['intent'] as String,
      medicationCodeableConcept: json['medicationCodeableConcept'] == null
          ? null
          : CodeableConcept.fromJson(
              json['medicationCodeableConcept'] as Map<String, dynamic>),
      requester: _$JsonConverterFromJson<Map<String, dynamic>, Reference>(
          json['requester'], const ReferenceConverter().fromJson),
    );

Map<String, dynamic> _$$MedicationRequestImplToJson(
        _$MedicationRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'intent': instance.intent,
      'medicationCodeableConcept': instance.medicationCodeableConcept,
      'requester': _$JsonConverterToJson<Map<String, dynamic>, Reference>(
          instance.requester, const ReferenceConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
