part of 'sync_bloc.dart';

@freezed
class SyncEvent with _$SyncEvent {
  // Service discovery and connection
  const factory SyncEvent.discoverServices() = _DiscoverServices;
  const factory SyncEvent.clearDiscoveredServices() = _ClearDiscoveredServices;
  const factory SyncEvent.connectToService(SSDPServiceInfo service) =
      _ConnectToService;
  const factory SyncEvent.disconnectFromService() = _DisconnectFromService;
  const factory SyncEvent.testConnection(SSDPServiceInfo service) =
      _TestConnection;

  // Data operations
  const factory SyncEvent.syncData() = _SyncData;

  // UI state management
  const factory SyncEvent.clearError() = _ClearError;

  // Token and connection management
  const factory SyncEvent.checkTokenStatus() = _CheckTokenStatus;
  const factory SyncEvent.checkConnectionValidity() = _CheckConnectionValidity;
}
