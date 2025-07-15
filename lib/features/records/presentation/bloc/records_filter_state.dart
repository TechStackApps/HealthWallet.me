part of 'records_filter_bloc.dart';

@freezed
class RecordsFilterState with _$RecordsFilterState {
  const factory RecordsFilterState({
    @Default({}) Set<String> activeFilters,
    @Default([]) List<String> availableFilters,
  }) = _RecordsFilterState;
}
