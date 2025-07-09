part of 'records_bloc.dart';

@freezed
class RecordsEvent with _$RecordsEvent {
  const factory RecordsEvent.loadRecords({
    String? sourceId,
    String? filter,
  }) = _LoadRecords;

  const factory RecordsEvent.updateFilters(List<String> filters) =
      _UpdateFilters;
}
