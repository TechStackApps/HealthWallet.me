part of 'sync_bloc.dart';

enum SyncStatus {
  disconnected,
  connecting,
  connected,
  syncing,
  synced,
  error,
}

@freezed
class SyncState with _$SyncState {
  const factory SyncState({
    @Default(false) bool isLoading,
    @Default(SyncStatus.disconnected) SyncStatus syncStatus,
    DateTime? lastSyncTime,
    String? error,
    String? successMessage,

    // QR Code Sync fields
    @Default(false) bool isQRScanning,
    SyncToken? syncToken, // Unified token instead of qrConfig
    String? workingBaseUrl, // The actual working URL (HTTP/HTTPS)
    bool? qrConnectionTestResult,
    String? qrError,

    // User information from sync server
    String? serverUsername,
    String? serverUserEmail,

    // Data loading and onboarding state
    @Default(false) bool isLoadingDemoData,
    @Default(false) bool hasDemoData,
    String? demoDataError,
    @Default(false) bool shouldShowOnboarding,
    @Default(false) bool hasSyncData, // Track when sync data has been loaded
  }) = _SyncState;
}
