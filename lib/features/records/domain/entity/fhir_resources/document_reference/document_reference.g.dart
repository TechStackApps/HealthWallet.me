// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentReferenceImpl _$$DocumentReferenceImplFromJson(
        Map<String, dynamic> json) =>
    _$DocumentReferenceImpl(
      id: json['id'] as String?,
      code: json['code'] == null
          ? null
          : CodeableConcept.fromJson(json['code'] as Map<String, dynamic>),
      title: json['title'] as String?,
      description: json['description'] as String?,
      status: json['status'] as String?,
      category: json['category'] == null
          ? null
          : CodeableConcept.fromJson(json['category'] as Map<String, dynamic>),
      docStatus: json['doc_status'] as String?,
      typeCoding: json['type_coding'] == null
          ? null
          : Coding.fromJson(json['type_coding'] as Map<String, dynamic>),
      classCoding: json['class_coding'] == null
          ? null
          : Coding.fromJson(json['class_coding'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
      securityLabelCoding: json['security_label_coding'] == null
          ? null
          : Coding.fromJson(
              json['security_label_coding'] as Map<String, dynamic>),
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      context: json['context'] == null
          ? null
          : DocumentReferenceContext.fromJson(
              json['context'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DocumentReferenceImplToJson(
        _$DocumentReferenceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'title': instance.title,
      'description': instance.description,
      'status': instance.status,
      'category': instance.category,
      'doc_status': instance.docStatus,
      'type_coding': instance.typeCoding,
      'class_coding': instance.classCoding,
      'created_at': instance.createdAt,
      'security_label_coding': instance.securityLabelCoding,
      'content': instance.content,
      'context': instance.context,
    };

_$DocumentReferenceContextImpl _$$DocumentReferenceContextImplFromJson(
        Map<String, dynamic> json) =>
    _$DocumentReferenceContextImpl(
      eventCoding: json['eventCoding'] == null
          ? null
          : Coding.fromJson(json['eventCoding'] as Map<String, dynamic>),
      facilityTypeCoding: json['facilityTypeCoding'] == null
          ? null
          : Coding.fromJson(json['facilityTypeCoding'] as Map<String, dynamic>),
      practiceSettingCoding: json['practiceSettingCoding'] == null
          ? null
          : Coding.fromJson(
              json['practiceSettingCoding'] as Map<String, dynamic>),
      periodStart: json['periodStart'] as String?,
      periodEnd: json['periodEnd'] as String?,
    );

Map<String, dynamic> _$$DocumentReferenceContextImplToJson(
        _$DocumentReferenceContextImpl instance) =>
    <String, dynamic>{
      'eventCoding': instance.eventCoding,
      'facilityTypeCoding': instance.facilityTypeCoding,
      'practiceSettingCoding': instance.practiceSettingCoding,
      'periodStart': instance.periodStart,
      'periodEnd': instance.periodEnd,
    };
