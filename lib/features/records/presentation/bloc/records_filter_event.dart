part of 'records_filter_bloc.dart';

@freezed
class RecordsFilterEvent with _$RecordsFilterEvent {
  const factory RecordsFilterEvent.load() = _Load;
  const factory RecordsFilterEvent.toggleFilter(String filter) = _ToggleFilter;
}
