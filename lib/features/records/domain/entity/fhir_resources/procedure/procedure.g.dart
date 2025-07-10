// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procedure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProcedureImpl _$$ProcedureImplFromJson(Map<String, dynamic> json) =>
    _$ProcedureImpl(
      id: json['id'] as String,
      status: json['status'] as String,
      code: CodeableConcept.fromJson(json['code'] as Map<String, dynamic>),
      performedDateTime: json['performedDateTime'] == null
          ? null
          : DateTime.parse(json['performedDateTime'] as String),
    );

Map<String, dynamic> _$$ProcedureImplToJson(_$ProcedureImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'code': instance.code,
      'performedDateTime': instance.performedDateTime?.toIso8601String(),
    };
