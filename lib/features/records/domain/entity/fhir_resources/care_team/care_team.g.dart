// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'care_team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CareTeamImpl _$$CareTeamImplFromJson(Map<String, dynamic> json) =>
    _$CareTeamImpl(
      id: json['id'] as String?,
      code: json['code'] == null
          ? null
          : CodeableConcept.fromJson(json['code'] as Map<String, dynamic>),
      name: json['name'] as String?,
      status: json['status'] as String?,
      periodStart: json['period_start'] as String?,
      periodEnd: json['period_end'] as String?,
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => CareTeamParticipant.fromJson(e as Map<String, dynamic>))
          .toList(),
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => CodeableConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
      subject: json['subject'] == null
          ? null
          : Reference.fromJson(json['subject'] as Map<String, dynamic>),
      encounter: json['encounter'] == null
          ? null
          : Reference.fromJson(json['encounter'] as Map<String, dynamic>),
      managingOrganization: json['managing_organization'] == null
          ? null
          : Reference.fromJson(
              json['managing_organization'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CareTeamImplToJson(_$CareTeamImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'status': instance.status,
      'period_start': instance.periodStart,
      'period_end': instance.periodEnd,
      'participants': instance.participants,
      'category': instance.category,
      'subject': instance.subject,
      'encounter': instance.encounter,
      'managing_organization': instance.managingOrganization,
    };

_$CareTeamParticipantImpl _$$CareTeamParticipantImplFromJson(
        Map<String, dynamic> json) =>
    _$CareTeamParticipantImpl(
      reference: json['reference'] == null
          ? null
          : Reference.fromJson(json['reference'] as Map<String, dynamic>),
      display: json['display'] as String?,
      role: json['role'] as String?,
      periodStart: json['periodStart'] as String?,
      periodEnd: json['periodEnd'] as String?,
    );

Map<String, dynamic> _$$CareTeamParticipantImplToJson(
        _$CareTeamParticipantImpl instance) =>
    <String, dynamic>{
      'reference': instance.reference,
      'display': instance.display,
      'role': instance.role,
      'periodStart': instance.periodStart,
      'periodEnd': instance.periodEnd,
    };
