part of 'records_bloc.dart';

@freezed
class RecordsState with _$RecordsState {
  const factory RecordsState({
    @Default(RecordsStatus.initial()) RecordsStatus status,
    @Default([]) List<TimelineResourceModel> resources,
    @Default({}) Set<String> activeFilters,
    @Default([]) List<String> availableFilters,
    String? sourceId,
    @Default(false) bool hasMorePages,
    @Default(RecordDetailStatus.initial())
    RecordDetailStatus recordDetailStatus,
    @Default({}) Map<String, List<FhirResourceDisplayModel>> relatedResources,
  }) = _RecordsState;
}

@freezed
class RecordsStatus with _$RecordsStatus {
  const factory RecordsStatus.initial() = _Initial;
  const factory RecordsStatus.loading() = _Loading;
  const factory RecordsStatus.success() = _Success;
  const factory RecordsStatus.failure(Object error) = _Failure;
}

@freezed
class RecordDetailStatus with _$RecordDetailStatus {
  const factory RecordDetailStatus.initial() = _DetailInitial;
  const factory RecordDetailStatus.loading() = _DetailLoading;
  const factory RecordDetailStatus.success() = _DetailSuccess;
  const factory RecordDetailStatus.failure(Object error) = _DetailFailure;
}
