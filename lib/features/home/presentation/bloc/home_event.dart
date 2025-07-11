part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.initialised() = _Initialised;
  const factory HomeEvent.sourceChanged(String source) = _SourceChanged;
  const factory HomeEvent.filtersChanged(Map<String, bool> filters) =
      _FiltersChanged;
  const factory HomeEvent.editModeChanged(bool editMode) = _EditModeChanged;
  const factory HomeEvent.recordsReordered(int oldIndex, int newIndex) =
      _RecordsReordered;
  const factory HomeEvent.vitalsReordered(int oldIndex, int newIndex) =
      _VitalsReordered;
}
