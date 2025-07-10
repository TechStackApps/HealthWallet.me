import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/codeable_concept.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_datatypes/reference.dart';

part 'encounter.freezed.dart';
part 'encounter.g.dart';

@freezed
class Encounter with _$Encounter {
  factory Encounter({
    String? id,
    CodeableConcept? code,
    @JsonKey(name: 'period_end') String? periodEnd,
    @JsonKey(name: 'period_start') String? periodStart,
    @JsonKey(name: 'has_participant') bool? hasParticipant,
    @JsonKey(name: 'location_display') String? locationDisplay,
    @JsonKey(name: 'encounter_type') List<CodeableConcept>? encounterType,
    @JsonKey(name: 'resource_class') String? resourceClass,
    @JsonKey(name: 'resource_status') String? resourceStatus,
    List<EncounterParticipant>? participant,
    List<CodeableConcept>? reasonCode,
  }) = _Encounter;

  factory Encounter.fromJson(Map<String, dynamic> json) =>
      _$EncounterFromJson(json);
}

@freezed
class EncounterParticipant with _$EncounterParticipant {
  factory EncounterParticipant({
    String? display,
    String? role,
    Reference? reference,
    String? text,
    String? periodStart,
  }) = _EncounterParticipant;

  factory EncounterParticipant.fromJson(Map<String, dynamic> json) =>
      _$EncounterParticipantFromJson(json);
}
