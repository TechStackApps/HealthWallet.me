part of 'sync_bloc.dart';

enum SyncStatus {
  disconnected,
  connecting,
  connected,
  syncing,
  error,
}

@freezed
class SyncState with _$SyncState {
  const factory SyncState({
    @Default(false) bool isLoading,
    @Default(false) bool isDiscovering,
    @Default(SyncStatus.disconnected) SyncStatus syncStatus,
    @Default([]) List<SSDPServiceInfo> discoveredServices,
    SSDPServiceInfo? connectedService,
    DateTime? lastDiscoveryTime,
    DateTime? lastSyncTime,
    bool? connectionTestResult,
    String? error,
  }) = _SyncState;
}
