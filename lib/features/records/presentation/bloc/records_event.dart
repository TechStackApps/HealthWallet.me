part of 'records_bloc.dart';

@freezed
class RecordsEvent with _$RecordsEvent {
  const factory RecordsEvent.fetchRecords({required String resourceType}) =
      _FetchRecords;
  const factory RecordsEvent.addFilter(String filter) = _AddFilter;
  const factory RecordsEvent.removeFilter(String filter) = _RemoveFilter;
  const factory RecordsEvent.clearFilters() = _ClearFilters;
}
