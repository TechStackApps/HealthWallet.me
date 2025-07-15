part of 'sync_bloc.dart';

@freezed
class SyncEvent with _$SyncEvent {
  const factory SyncEvent.syncData() = _SyncData;
  const factory SyncEvent.syncDataWithJson(String jsonData) = _SyncDataWithJson;
  const factory SyncEvent.historyLoaded() = _HistoryLoaded;
  const factory SyncEvent.tokenStatusLoaded() = _TokenStatusLoaded;
  const factory SyncEvent.tokenRevoked() = _TokenRevoked;
  const factory SyncEvent.checkTokenStatus() = _CheckTokenStatus;
}
