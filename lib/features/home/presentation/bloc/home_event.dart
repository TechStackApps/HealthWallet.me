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

@freezed
class HomeFiltersChanged extends HomeEvent with _$HomeFiltersChanged {
  const factory HomeFiltersChanged(Map<String, bool> filters) =
      _HomeFiltersChanged;
}

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
