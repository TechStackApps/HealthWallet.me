part of 'encounter_detail_bloc.dart';

enum EncounterDetailStatus { initial, loading, success, failure }

@freezed
class EncounterDetailState with _$EncounterDetailState {
  const factory EncounterDetailState({
    @Default(EncounterDetailStatus.initial) EncounterDetailStatus status,
    @Default({}) Map<String, List<FhirResourceDisplayModel>> relatedResources,
    @Default('') String error,
  }) = _EncounterDetailState;
}
