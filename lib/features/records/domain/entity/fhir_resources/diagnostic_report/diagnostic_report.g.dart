// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnostic_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiagnosticReportImpl _$$DiagnosticReportImplFromJson(
        Map<String, dynamic> json) =>
    _$DiagnosticReportImpl(
      id: json['id'] as String,
      code: json['code'] == null
          ? null
          : CodeableConcept.fromJson(json['code'] as Map<String, dynamic>),
      title: json['title'] as String?,
      status: json['status'] as String?,
      effectiveDatetime: json['effective_datetime'] as String?,
      categoryCoding: (json['category_coding'] as List<dynamic>?)
          ?.map((e) => CodeableConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
      codeCoding: (json['code_coding'] as List<dynamic>?)
          ?.map((e) => Coding.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasCategoryCoding: json['has_category_coding'] as bool?,
      hasPerformer: json['has_performer'] as bool?,
      conclusion: json['conclusion'] as String?,
      performer: json['performer'] == null
          ? null
          : Reference.fromJson(json['performer'] as Map<String, dynamic>),
      issued: json['issued'] as String?,
      presentedForm: (json['presented_form'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      isCategoryLabReport: json['is_category_lab_report'] as bool?,
    );

Map<String, dynamic> _$$DiagnosticReportImplToJson(
        _$DiagnosticReportImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'title': instance.title,
      'status': instance.status,
      'effective_datetime': instance.effectiveDatetime,
      'category_coding': instance.categoryCoding,
      'code_coding': instance.codeCoding,
      'has_category_coding': instance.hasCategoryCoding,
      'has_performer': instance.hasPerformer,
      'conclusion': instance.conclusion,
      'performer': instance.performer,
      'issued': instance.issued,
      'presented_form': instance.presentedForm,
      'is_category_lab_report': instance.isCategoryLabReport,
    };
