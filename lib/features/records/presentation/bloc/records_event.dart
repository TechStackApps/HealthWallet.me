part of 'records_bloc.dart';

@freezed
class RecordsEvent with _$RecordsEvent {
  const factory RecordsEvent.fetchRecords({String? filter}) = FetchRecords;
  const factory RecordsEvent.fetchAllergyRecords(Allergy allergy) =
      FetchAllergyRecords;
  const factory RecordsEvent.addFilter(String filter) = AddFilter;
  const factory RecordsEvent.removeFilter(String filter) = RemoveFilter;
  const factory RecordsEvent.clearFilters() = ClearFilters;
}
