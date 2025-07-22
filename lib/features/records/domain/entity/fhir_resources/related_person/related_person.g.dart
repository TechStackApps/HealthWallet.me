// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'related_person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RelatedPersonImpl _$$RelatedPersonImplFromJson(Map<String, dynamic> json) =>
    _$RelatedPersonImpl(
      id: json['id'] as String?,
      patient: json['patient'] as String?,
      name: json['name'] as String?,
      birthdate: json['birthdate'] as String?,
      gender: json['gender'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      relatedPersonTelecom: (json['related_person_telecom'] as List<dynamic>?)
          ?.map((e) => Telecom.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RelatedPersonImplToJson(_$RelatedPersonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient': instance.patient,
      'name': instance.name,
      'birthdate': instance.birthdate,
      'gender': instance.gender,
      'address': instance.address,
      'related_person_telecom': instance.relatedPersonTelecom,
    };
