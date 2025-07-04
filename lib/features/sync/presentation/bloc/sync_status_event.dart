part of 'sync_status_bloc.dart';

@freezed
class SyncStatusEvent with _$SyncStatusEvent {
  const factory SyncStatusEvent.checkSyncStatus() = _CheckSyncStatus;
}
