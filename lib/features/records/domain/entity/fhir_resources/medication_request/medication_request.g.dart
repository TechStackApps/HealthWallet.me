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
      subject: _$JsonConverterFromJson<Map<String, dynamic>, Reference>(
          json['subject'], const ReferenceConverter().fromJson),
      encounter: _$JsonConverterFromJson<Map<String, dynamic>, Reference>(
          json['encounter'], const ReferenceConverter().fromJson),
      authoredOn: json['authoredOn'] as String?,
    );

Map<String, dynamic> _$$MedicationRequestImplToJson(
        _$MedicationRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'intent': instance.intent,
      'medicationCodeableConcept': instance.medicationCodeableConcept?.toJson(),
      'requester': _$JsonConverterToJson<Map<String, dynamic>, Reference>(
          instance.requester, const ReferenceConverter().toJson),
      'subject': _$JsonConverterToJson<Map<String, dynamic>, Reference>(
          instance.subject, const ReferenceConverter().toJson),
      'encounter': _$JsonConverterToJson<Map<String, dynamic>, Reference>(
          instance.encounter, const ReferenceConverter().toJson),
      'authoredOn': instance.authoredOn,
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
