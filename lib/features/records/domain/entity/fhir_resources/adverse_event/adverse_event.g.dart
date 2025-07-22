// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adverse_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdverseEventImpl _$$AdverseEventImplFromJson(Map<String, dynamic> json) =>
    _$AdverseEventImpl(
      id: json['id'] as String?,
      code: json['code'] == null
          ? null
          : CodeableConcept.fromJson(json['code'] as Map<String, dynamic>),
      subject: json['subject'] == null
          ? null
          : Reference.fromJson(json['subject'] as Map<String, dynamic>),
      description: json['description'] as String?,
      eventType: json['event_type'] as String?,
      hasEventType: json['has_event_type'] as bool?,
      date: json['date'] as String?,
      seriousness: json['seriousness'] == null
          ? null
          : CodeableConcept.fromJson(
              json['seriousness'] as Map<String, dynamic>),
      hasSeriousness: json['has_seriousness'] as bool?,
      actuality: json['actuality'] as String?,
      event: json['event'] == null
          ? null
          : CodeableConcept.fromJson(json['event'] as Map<String, dynamic>),
      hasEvent: json['has_event'] as bool?,
    );

Map<String, dynamic> _$$AdverseEventImplToJson(_$AdverseEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'subject': instance.subject,
      'description': instance.description,
      'event_type': instance.eventType,
      'has_event_type': instance.hasEventType,
      'date': instance.date,
      'seriousness': instance.seriousness,
      'has_seriousness': instance.hasSeriousness,
      'actuality': instance.actuality,
      'event': instance.event,
      'has_event': instance.hasEvent,
    };
