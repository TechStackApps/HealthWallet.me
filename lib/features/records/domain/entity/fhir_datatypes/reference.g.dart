// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResolvedReferenceImpl _$$ResolvedReferenceImplFromJson(
        Map<String, dynamic> json) =>
    _$ResolvedReferenceImpl(
      FhirResource.fromJson(json['resource'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ResolvedReferenceImplToJson(
        _$ResolvedReferenceImpl instance) =>
    <String, dynamic>{
      'resource': instance.resource,
      'runtimeType': instance.$type,
    };

_$UnresolvedReferenceImpl _$$UnresolvedReferenceImplFromJson(
        Map<String, dynamic> json) =>
    _$UnresolvedReferenceImpl(
      json['reference'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UnresolvedReferenceImplToJson(
        _$UnresolvedReferenceImpl instance) =>
    <String, dynamic>{
      'reference': instance.reference,
      'runtimeType': instance.$type,
    };
