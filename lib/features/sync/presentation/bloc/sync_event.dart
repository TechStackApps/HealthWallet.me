part of 'sync_bloc.dart';

abstract class SyncEvent {
  const SyncEvent();
}

@freezed
class SyncInitialised extends SyncEvent with _$SyncInitialised {
  const factory SyncInitialised() = _SyncInitialised;
}

@freezed
class SyncDataInitiated extends SyncEvent with _$SyncDataInitiated {
  const factory SyncDataInitiated({
    required String qrData,
  }) = _SyncData;
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
class SyncConnectWithQR extends SyncEvent with _$SyncConnectWithQR {
  const factory SyncConnectWithQR() = _SyncConnectWithQR;
}

@freezed
class SyncScanNewPressed extends SyncEvent with _$SyncScanNewPressed {
  const factory SyncScanNewPressed() = _SyncScanNewPressed;
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
