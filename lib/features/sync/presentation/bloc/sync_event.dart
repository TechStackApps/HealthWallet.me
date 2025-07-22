part of 'sync_bloc.dart';

@freezed
sealed class SyncEvent with _$SyncEvent {
  const SyncEvent._();
  const factory SyncEvent.syncData() = _SyncData;
  const factory SyncEvent.syncDataWithJson(String jsonData) = _SyncDataWithJson;
  const factory SyncEvent.historyLoaded() = _HistoryLoaded;
  const factory SyncEvent.tokenStatusLoaded() = _TokenStatusLoaded;
  const factory SyncEvent.tokenRevoked({String? tokenId}) = _TokenRevoked;
  const factory SyncEvent.checkTokenStatus() = _CheckTokenStatus;
  const factory SyncEvent.checkConnectionValidity() = _CheckConnectionValidity;
}
