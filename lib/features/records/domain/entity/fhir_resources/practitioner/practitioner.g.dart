// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practitioner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PractitionerImpl _$$PractitionerImplFromJson(Map<String, dynamic> json) =>
    _$PractitionerImpl(
      id: json['id'] as String,
      name: (json['name'] as List<dynamic>?)
          ?.map((e) =>
              const HumanNameConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$$PractitionerImplToJson(_$PractitionerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name?.map(const HumanNameConverter().toJson).toList(),
      'gender': instance.gender,
    };
