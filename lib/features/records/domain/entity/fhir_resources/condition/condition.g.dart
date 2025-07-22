// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConditionImpl _$$ConditionImplFromJson(Map<String, dynamic> json) =>
    _$ConditionImpl(
      id: json['id'] as String?,
      code: json['code'] == null
          ? null
          : CodeableConcept.fromJson(json['code'] as Map<String, dynamic>),
      codeText: json['code_text'] as String?,
      codeId: json['code_id'] as String?,
      codeSystem: json['code_system'] as String?,
      severityText: json['severity_text'] as String?,
      hasAsserter: json['has_asserter'] as bool?,
      asserter: json['asserter'] == null
          ? null
          : Reference.fromJson(json['asserter'] as Map<String, dynamic>),
      hasBodySite: json['has_body_site'] as bool?,
      bodySite: (json['body_site'] as List<dynamic>?)
          ?.map((e) => CodeableConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
      clinicalStatus: json['clinical_status'] as String?,
      dateRecorded: json['date_recorded'] as String?,
      onsetDatetime: json['onset_datetime'] as String?,
      abatementDatetime: json['abatement_datetime'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$ConditionImplToJson(_$ConditionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'code_text': instance.codeText,
      'code_id': instance.codeId,
      'code_system': instance.codeSystem,
      'severity_text': instance.severityText,
      'has_asserter': instance.hasAsserter,
      'asserter': instance.asserter,
      'has_body_site': instance.hasBodySite,
      'body_site': instance.bodySite,
      'clinical_status': instance.clinicalStatus,
      'date_recorded': instance.dateRecorded,
      'onset_datetime': instance.onsetDatetime,
      'abatement_datetime': instance.abatementDatetime,
      'note': instance.note,
    };
