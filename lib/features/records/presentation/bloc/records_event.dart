part of 'records_bloc.dart';

abstract class RecordsEvent {}

@freezed
class RecordsInitialised extends RecordsEvent with _$RecordsInitialised {
  const factory RecordsInitialised() = _RecordsInitialised;
}

@freezed
class RecordsLoadMore extends RecordsEvent with _$RecordsLoadMore {
  const factory RecordsLoadMore() = _RecordsLoadMore;
}

@freezed
class RecordsSourceChanged extends RecordsEvent with _$RecordsSourceChanged {
  const factory RecordsSourceChanged(String? sourceId) = _RecordsSourceChanged;
}

@freezed
class RecordsFiltersApplied extends RecordsEvent with _$RecordsFiltersApplied {
  const factory RecordsFiltersApplied(List<FhirType> filters) =
      _RecordsFiltersApplied;
}

@freezed
class RecordsFilterRemoved extends RecordsEvent with _$RecordsFilterRemoved {
  const factory RecordsFilterRemoved(FhirType filter) =
      _RecordsFilterRemoved;
}

@freezed
class RecordDetailLoaded extends RecordsEvent with _$RecordDetailLoaded {
  const factory RecordDetailLoaded(IFhirResource resource) = _RecordDetailLoaded;
}
