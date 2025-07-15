part of 'encounter_detail_bloc.dart';

@freezed
class EncounterDetailEvent with _$EncounterDetailEvent {
  const factory EncounterDetailEvent.load(String encounterId) = _Load;
}
