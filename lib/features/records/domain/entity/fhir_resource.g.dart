// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fhir_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FhirResourceImpl _$$FhirResourceImplFromJson(Map<String, dynamic> json) =>
    _$FhirResourceImpl(
      id: json['id'] as String?,
      resourceType: json['source_resource_type'] as String,
      resourceJson: json['resource_raw'] as Map<String, dynamic>,
      sourceId: json['source_id'] as String?,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$FhirResourceImplToJson(_$FhirResourceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'source_resource_type': instance.resourceType,
      'resource_raw': instance.resourceJson,
      'source_id': instance.sourceId,
      'updated_at': instance.updatedAt.toIso8601String(),
    };
