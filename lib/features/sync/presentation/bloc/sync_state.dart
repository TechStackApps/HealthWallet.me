part of 'sync_bloc.dart';

enum SyncStatus {
  initial,
  syncing,
  synced,
}

@freezed
class SyncState with _$SyncState {
  const factory SyncState({
    SyncQrData? syncQrData,
    @Default(false) bool isLoading,
    @Default(SyncStatus.initial) SyncStatus syncStatus,
    String? errorMessage,
    @Default(false) bool isQRScanning,
    String? lastSyncTime,
    String? successMessage,

    // Data loading and onboarding state
    @Default(false) bool isLoadingDemoData,
    @Default(false) bool hasDemoData,
    String? demoDataError,
    @Default(false) bool shouldShowOnboarding,
    @Default(false) bool hasSyncData, // Track when sync data has been loaded
  }) = _SyncState;
}
