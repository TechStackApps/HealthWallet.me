import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/coding.dart';

part 'appointment.freezed.dart';
part 'appointment.g.dart';

@freezed
class Appointment with _$Appointment {
  factory Appointment({
    String? id,
    CodeableConcept? code,
    String? description,
    String? status,
    String? start,
    @JsonKey(name: 'type_coding') Coding? typeCoding,
    String? comment,
    String? participant,
    @JsonKey(name: 'participant_patient') String? participantPatient,
    @JsonKey(name: 'participant_practitioner') String? participantPractitioner,
    @JsonKey(name: 'participant_location') String? participantLocation,
    @JsonKey(name: 'minutes_duration') String? minutesDuration,
    String? reason,
    @JsonKey(name: 'cancelation_reason') String? cancelationReason,
    @JsonKey(name: 'service_category') String? serviceCategory,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);
}
