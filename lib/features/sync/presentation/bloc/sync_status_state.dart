part of 'sync_status_bloc.dart';

@freezed
class SyncStatusState with _$SyncStatusState {
  const factory SyncStatusState.initial() = _Initial;
  const factory SyncStatusState.loading() = _Loading;
  const factory SyncStatusState.success({required bool isSynced}) = _Success;
  const factory SyncStatusState.error() = _Error;
}
