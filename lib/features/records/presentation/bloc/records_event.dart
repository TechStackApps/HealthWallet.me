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
class RecordsFilterChanged extends RecordsEvent with _$RecordsFilterChanged {
  const factory RecordsFilterChanged(Set<String> newFilters) =
      _RecordsFilterChanged;
}

@freezed
class RecordsSourceChanged extends RecordsEvent with _$RecordsSourceChanged {
  const factory RecordsSourceChanged(String? sourceId) = _RecordsSourceChanged;
}

@freezed
class RecordsFilterToggled extends RecordsEvent with _$RecordsFilterToggled {
  const factory RecordsFilterToggled(String filter) = _RecordsFilterToggled;
}

@freezed
class RecordsLoadFilters extends RecordsEvent with _$RecordsLoadFilters {
  const factory RecordsLoadFilters() = _RecordsLoadFilters;
}

@freezed
class RecordDetailLoaded extends RecordsEvent with _$RecordDetailLoaded {
  const factory RecordDetailLoaded(String recordId) = _RecordDetailLoaded;
}
