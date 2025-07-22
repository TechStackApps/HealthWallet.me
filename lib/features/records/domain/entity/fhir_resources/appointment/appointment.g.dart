// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentImpl _$$AppointmentImplFromJson(Map<String, dynamic> json) =>
    _$AppointmentImpl(
      id: json['id'] as String?,
      code: json['code'] == null
          ? null
          : CodeableConcept.fromJson(json['code'] as Map<String, dynamic>),
      description: json['description'] as String?,
      status: json['status'] as String?,
      start: json['start'] as String?,
      typeCoding: json['type_coding'] == null
          ? null
          : Coding.fromJson(json['type_coding'] as Map<String, dynamic>),
      comment: json['comment'] as String?,
      participant: json['participant'] as String?,
      participantPatient: json['participant_patient'] as String?,
      participantPractitioner: json['participant_practitioner'] as String?,
      participantLocation: json['participant_location'] as String?,
      minutesDuration: json['minutes_duration'] as String?,
      reason: json['reason'] as String?,
      cancelationReason: json['cancelation_reason'] as String?,
      serviceCategory: json['service_category'] as String?,
    );

Map<String, dynamic> _$$AppointmentImplToJson(_$AppointmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'description': instance.description,
      'status': instance.status,
      'start': instance.start,
      'type_coding': instance.typeCoding,
      'comment': instance.comment,
      'participant': instance.participant,
      'participant_patient': instance.participantPatient,
      'participant_practitioner': instance.participantPractitioner,
      'participant_location': instance.participantLocation,
      'minutes_duration': instance.minutesDuration,
      'reason': instance.reason,
      'cancelation_reason': instance.cancelationReason,
      'service_category': instance.serviceCategory,
    };
