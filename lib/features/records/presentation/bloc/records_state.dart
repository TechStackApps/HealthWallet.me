part of 'records_bloc.dart';

@freezed
class RecordsState with _$RecordsState {
  const factory RecordsState.initial({
    @Default([]) List<String> filters,
    @Default([]) List<String> availableFilters,
  }) = _Initial;
  const factory RecordsState.loading({
    @Default([]) List<String> filters,
    @Default([]) List<String> availableFilters,
  }) = _Loading;
  const factory RecordsState.loaded(
    List<RecordsEntry> entries,
    List<String> filters,
    List<String> availableFilters,
  ) = _Loaded;
  const factory RecordsState.error(
    String message, {
    @Default([]) List<String> filters,
    @Default([]) List<String> availableFilters,
  }) = _Error;
}
