import 'package:freezed_annotation/freezed_annotation.dart';

part 'encounter.freezed.dart';
part 'encounter.g.dart';

@freezed
class Encounter with _$Encounter {
  factory Encounter({
    String? id,
    String? status,
    List<EncounterParticipant>? participant,
  }) = _Encounter;

  factory Encounter.fromJson(Map<String, dynamic> json) =>
      _$EncounterFromJson(json);
}

@freezed
class EncounterParticipant with _$EncounterParticipant {
  factory EncounterParticipant({
    Reference? individual,
  }) = _EncounterParticipant;

  factory EncounterParticipant.fromJson(Map<String, dynamic> json) =>
      _$EncounterParticipantFromJson(json);
}

@freezed
class Reference with _$Reference {
  factory Reference({
    String? reference,
    String? display,
  }) = _Reference;

  factory Reference.fromJson(Map<String, dynamic> json) =>
      _$ReferenceFromJson(json);
}
