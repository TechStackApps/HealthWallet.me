// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationImpl _$$LocationImplFromJson(Map<String, dynamic> json) =>
    _$LocationImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      status: json['status'] as String?,
      description: json['description'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      telecom: (json['telecom'] as List<dynamic>?)
          ?.map((e) => Telecom.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: (json['type'] as List<dynamic>?)
          ?.map((e) => CodeableConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
      physicalType: json['physical_type'] == null
          ? null
          : CodeableConcept.fromJson(
              json['physical_type'] as Map<String, dynamic>),
      mode: json['mode'] as String?,
      managingOrganization: json['managing_organization'] == null
          ? null
          : Reference.fromJson(
              json['managing_organization'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'description': instance.description,
      'address': instance.address,
      'telecom': instance.telecom,
      'type': instance.type,
      'physical_type': instance.physicalType,
      'mode': instance.mode,
      'managing_organization': instance.managingOrganization,
    };
