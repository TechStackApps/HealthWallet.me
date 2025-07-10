// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practitioner_role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PractitionerRoleImpl _$$PractitionerRoleImplFromJson(
        Map<String, dynamic> json) =>
    _$PractitionerRoleImpl(
      id: json['id'] as String?,
      status: json['status'] as String?,
      codes: (json['codes'] as List<dynamic>?)
          ?.map((e) => CodeableConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
      specialties: (json['specialties'] as List<dynamic>?)
          ?.map((e) => CodeableConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
      organization: json['organization'] == null
          ? null
          : Reference.fromJson(json['organization'] as Map<String, dynamic>),
      practitioner: json['practitioner'] == null
          ? null
          : Reference.fromJson(json['practitioner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PractitionerRoleImplToJson(
        _$PractitionerRoleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'codes': instance.codes,
      'specialties': instance.specialties,
      'organization': instance.organization,
      'practitioner': instance.practitioner,
    };
