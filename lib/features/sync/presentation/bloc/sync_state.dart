part of 'sync_bloc.dart';

@freezed
sealed class SyncStatus with _$SyncStatus {
  const factory SyncStatus.initial() = _InitialStatus;
  const factory SyncStatus.loading() = _LoadingStatus;
  const factory SyncStatus.success() = _SuccessStatus;
  const factory SyncStatus.failure(String error) = _FailureStatus;
}

@freezed
class SyncState with _$SyncState {
  const factory SyncState({
    @Default(SyncStatus.initial()) SyncStatus status,
    @Default([]) List<DateTime> history,
  }) = _SyncState;
}
