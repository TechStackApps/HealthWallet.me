part of 'sync_bloc.dart';

abstract class SyncEvent {
  const SyncEvent();
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
class SyncClearSuccess extends SyncEvent with _$SyncClearSuccess {
  const factory SyncClearSuccess() = _SyncClearSuccess;
}

@freezed
class SyncRestoreState extends SyncEvent with _$SyncRestoreState {
  const factory SyncRestoreState() = _SyncRestoreState;
}

@freezed
class SyncScanQRCode extends SyncEvent with _$SyncScanQRCode {
  const factory SyncScanQRCode() = _SyncScanQRCode;
}

@freezed
class SyncProcessQRCode extends SyncEvent with _$SyncProcessQRCode {
  const factory SyncProcessQRCode(String qrData) = _SyncProcessQRCode;
}

@freezed
class SyncConnectWithQR extends SyncEvent with _$SyncConnectWithQR {
  const factory SyncConnectWithQR() = _SyncConnectWithQR;
}

@freezed
class SyncDisconnectQR extends SyncEvent with _$SyncDisconnectQR {
  const factory SyncDisconnectQR() = _SyncDisconnectQR;
}

@freezed
class SyncClearToken extends SyncEvent with _$SyncClearToken {
  const factory SyncClearToken() = _SyncClearToken;
}

@freezed
class SyncResetStatus extends SyncEvent with _$SyncResetStatus {
  const factory SyncResetStatus() = _SyncResetStatus;
}

@freezed
class SyncCancelQRScanning extends SyncEvent with _$SyncCancelQRScanning {
  const factory SyncCancelQRScanning() = _SyncCancelQRScanning;
}

@freezed
class SyncLoadDemoData extends SyncEvent with _$SyncLoadDemoData {
  const factory SyncLoadDemoData() = _SyncLoadDemoData;
}

@freezed
class SyncDataCompleted extends SyncEvent with _$SyncDataCompleted {
  const factory SyncDataCompleted({
    required String sourceId,
    required bool isSuccess,
    String? errorMessage,
  }) = _SyncDataCompleted;
}

@freezed
class OnboardingOverlayTriggered extends SyncEvent
    with _$OnboardingOverlayTriggered {
  const factory OnboardingOverlayTriggered() = _OnboardingOverlayTriggered;
}

@freezed
class SyncResetOnboarding extends SyncEvent with _$SyncResetOnboarding {
  const factory SyncResetOnboarding() = _SyncResetOnboarding;
}
