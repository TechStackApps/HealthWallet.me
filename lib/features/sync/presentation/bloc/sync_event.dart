part of 'sync_bloc.dart';

abstract class SyncEvent {
  const SyncEvent();
}

@freezed
class SyncDiscoverServices extends SyncEvent with _$SyncDiscoverServices {
  const factory SyncDiscoverServices() = _SyncDiscoverServices;
}

@freezed
class SyncClearDiscoveredServices extends SyncEvent
    with _$SyncClearDiscoveredServices {
  const factory SyncClearDiscoveredServices() = _SyncClearDiscoveredServices;
}

@freezed
class SyncConnectToService extends SyncEvent with _$SyncConnectToService {
  const factory SyncConnectToService(SSDPServiceInfo service) =
      _SyncConnectToService;
}

@freezed
class SyncDisconnectFromService extends SyncEvent
    with _$SyncDisconnectFromService {
  const factory SyncDisconnectFromService() = _SyncDisconnectFromService;
}

@freezed
class SyncTestConnection extends SyncEvent with _$SyncTestConnection {
  const factory SyncTestConnection(SSDPServiceInfo service) =
      _SyncTestConnection;
}

@freezed
class SyncData extends SyncEvent with _$SyncData {
  const factory SyncData() = _SyncData;
}

@freezed
class SyncClearError extends SyncEvent with _$SyncClearError {
  const factory SyncClearError() = _SyncClearError;
}

@freezed
class SyncCheckTokenStatus extends SyncEvent with _$SyncCheckTokenStatus {
  const factory SyncCheckTokenStatus() = _SyncCheckTokenStatus;
}

@freezed
class SyncCheckConnectionValidity extends SyncEvent
    with _$SyncCheckConnectionValidity {
  const factory SyncCheckConnectionValidity() = _SyncCheckConnectionValidity;
}

@freezed
class SyncRestoreState extends SyncEvent with _$SyncRestoreState {
  const factory SyncRestoreState() = _SyncRestoreState;
}
