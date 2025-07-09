part of 'records_bloc.dart';

enum RecordsStatus { initial, loading, success, failure }

@freezed
class RecordsState with _$RecordsState {
  const factory RecordsState({
    @Default(RecordsStatus.initial) RecordsStatus status,
    @Default([]) List<FhirResource> entries,
    @Default([]) List<String> filters,
    @Default([]) List<String> availableFilters,
    @Default('') String error,
  }) = _RecordsState;
}
