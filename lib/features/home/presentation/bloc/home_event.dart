part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

@freezed
class HomeInitialised extends HomeEvent with _$HomeInitialised {
  const factory HomeInitialised() = _HomeInitialised;
}

@freezed
class HomeSourceChanged extends HomeEvent with _$HomeSourceChanged {
  const factory HomeSourceChanged(String source) = _HomeSourceChanged;
}

// Removed: HomeFiltersChanged (use HomeRecordsFiltersChanged)

@freezed
class HomeEditModeChanged extends HomeEvent with _$HomeEditModeChanged {
  const factory HomeEditModeChanged(bool editMode) = _HomeEditModeChanged;
}

@freezed
class HomeRecordsReordered extends HomeEvent with _$HomeRecordsReordered {
  const factory HomeRecordsReordered(int oldIndex, int newIndex) =
      _HomeRecordsReordered;
}

@freezed
class HomeVitalsReordered extends HomeEvent with _$HomeVitalsReordered {
  const factory HomeVitalsReordered(int oldIndex, int newIndex) =
      _HomeVitalsReordered;
}

@freezed
class HomeVitalsFiltersChanged extends HomeEvent
    with _$HomeVitalsFiltersChanged {
  const factory HomeVitalsFiltersChanged(Map<PatientVitalType, bool> filters) =
      _HomeVitalsFiltersChanged;
}

@freezed
class HomeRecordsFiltersChanged extends HomeEvent
    with _$HomeRecordsFiltersChanged {
  const factory HomeRecordsFiltersChanged(
      Map<HomeRecordsCategory, bool> filters) = _HomeRecordsFiltersChanged;
}

@freezed
class HomePatientSelected extends HomeEvent with _$HomePatientSelected {
  const factory HomePatientSelected(
      String? patientSourceId, String? patientName) = _HomePatientSelected;
}
