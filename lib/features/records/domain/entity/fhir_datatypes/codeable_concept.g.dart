// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'codeable_concept.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CodeableConceptImpl _$$CodeableConceptImplFromJson(
        Map<String, dynamic> json) =>
    _$CodeableConceptImpl(
      coding: (json['coding'] as List<dynamic>?)
          ?.map((e) => Coding.fromJson(e as Map<String, dynamic>))
          .toList(),
      text: json['text'] as String?,
    );

Map<String, dynamic> _$$CodeableConceptImplToJson(
        _$CodeableConceptImpl instance) =>
    <String, dynamic>{
      'coding': instance.coding,
      'text': instance.text,
    };
