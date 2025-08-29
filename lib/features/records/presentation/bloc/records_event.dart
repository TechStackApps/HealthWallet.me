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
  const factory RecordsFilterRemoved(FhirType filter) = _RecordsFilterRemoved;
}

@freezed
class RecordDetailLoaded extends RecordsEvent with _$RecordDetailLoaded {
  const factory RecordDetailLoaded(IFhirResource resource) =
      _RecordsDetailLoaded;
}

@freezed
class LoadDemoData extends RecordsEvent with _$LoadDemoData {
  const factory LoadDemoData() = _LoadDemoData;
}

@freezed
class ClearDemoData extends RecordsEvent with _$ClearDemoData {
  const factory ClearDemoData() = _ClearDemoData;
}

@freezed
class RecordsSearch extends RecordsEvent with _$RecordsSearch {
  const factory RecordsSearch(String query) = _RecordsSearch;
}

@freezed
class RecordsSearchExecuted extends RecordsEvent with _$RecordsSearchExecuted {
  const factory RecordsSearchExecuted(String query) = _RecordsSearchExecuted;
}

@freezed
class RecordsSharePressed extends RecordsEvent with _$RecordsSharePressed {
  const factory RecordsSharePressed() = _RecordsSharePressed;
}

