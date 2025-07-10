// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encounter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EncounterImpl _$$EncounterImplFromJson(Map<String, dynamic> json) =>
    _$EncounterImpl(
      id: json['id'] as String?,
      code: json['code'] == null
          ? null
          : CodeableConcept.fromJson(json['code'] as Map<String, dynamic>),
      periodEnd: json['period_end'] as String?,
      periodStart: json['period_start'] as String?,
      hasParticipant: json['has_participant'] as bool?,
      locationDisplay: json['location_display'] as String?,
      encounterType: (json['encounter_type'] as List<dynamic>?)
          ?.map((e) => CodeableConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
      resourceClass: json['resource_class'] as String?,
      resourceStatus: json['resource_status'] as String?,
      participant: (json['participant'] as List<dynamic>?)
          ?.map((e) => EncounterParticipant.fromJson(e as Map<String, dynamic>))
          .toList(),
      reasonCode: (json['reasonCode'] as List<dynamic>?)
          ?.map((e) => CodeableConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$EncounterImplToJson(_$EncounterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'period_end': instance.periodEnd,
      'period_start': instance.periodStart,
      'has_participant': instance.hasParticipant,
      'location_display': instance.locationDisplay,
      'encounter_type': instance.encounterType,
      'resource_class': instance.resourceClass,
      'resource_status': instance.resourceStatus,
      'participant': instance.participant,
      'reasonCode': instance.reasonCode,
    };

_$EncounterParticipantImpl _$$EncounterParticipantImplFromJson(
        Map<String, dynamic> json) =>
    _$EncounterParticipantImpl(
      display: json['display'] as String?,
      role: json['role'] as String?,
      reference: json['reference'] == null
          ? null
          : Reference.fromJson(json['reference'] as Map<String, dynamic>),
      text: json['text'] as String?,
      periodStart: json['periodStart'] as String?,
    );

Map<String, dynamic> _$$EncounterParticipantImplToJson(
        _$EncounterParticipantImpl instance) =>
    <String, dynamic>{
      'display': instance.display,
      'role': instance.role,
      'reference': instance.reference,
      'text': instance.text,
      'periodStart': instance.periodStart,
    };
