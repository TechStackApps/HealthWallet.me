// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fhir_bundle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FhirBundleImpl _$$FhirBundleImplFromJson(Map<String, dynamic> json) =>
    _$FhirBundleImpl(
      resourceType: json['resourceType'] as String,
      type: json['type'] as String,
      total: (json['total'] as num).toInt(),
      entry: (json['entry'] as List<dynamic>)
          .map((e) => BundleEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FhirBundleImplToJson(_$FhirBundleImpl instance) =>
    <String, dynamic>{
      'resourceType': instance.resourceType,
      'type': instance.type,
      'total': instance.total,
      'entry': instance.entry,
    };

_$BundleEntryImpl _$$BundleEntryImplFromJson(Map<String, dynamic> json) =>
    _$BundleEntryImpl(
      resource: FhirResource.fromJson(json['resource'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BundleEntryImplToJson(_$BundleEntryImpl instance) =>
    <String, dynamic>{
      'resource': instance.resource,
    };
