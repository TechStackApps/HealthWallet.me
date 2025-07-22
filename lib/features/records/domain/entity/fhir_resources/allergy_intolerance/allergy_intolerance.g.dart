// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allergy_intolerance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllergyIntoleranceImpl _$$AllergyIntoleranceImplFromJson(
        Map<String, dynamic> json) =>
    _$AllergyIntoleranceImpl(
      id: json['id'] as String,
      title: json['title'] as String?,
      status: json['status'] as String?,
      recordedDate: json['recorded_date'] as String?,
      substanceCoding: (json['substance_coding'] as List<dynamic>?)
          ?.map((e) => Coding.fromJson(e as Map<String, dynamic>))
          .toList(),
      asserter: json['asserter'] == null
          ? null
          : Reference.fromJson(json['asserter'] as Map<String, dynamic>),
      note: (json['note'] as List<dynamic>?)
          ?.map((e) => Note.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String?,
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      patient: json['patient'] == null
          ? null
          : Reference.fromJson(json['patient'] as Map<String, dynamic>),
      code: json['code'] == null
          ? null
          : CodeableConcept.fromJson(json['code'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AllergyIntoleranceImplToJson(
        _$AllergyIntoleranceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': instance.status,
      'recorded_date': instance.recordedDate,
      'substance_coding': instance.substanceCoding,
      'asserter': instance.asserter,
      'note': instance.note,
      'type': instance.type,
      'category': instance.category,
      'patient': instance.patient,
      'code': instance.code,
    };
