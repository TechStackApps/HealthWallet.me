part of 'sync_bloc.dart';

abstract class SyncEvent {
  const SyncEvent();
}

@freezed
class SyncInitialised extends SyncEvent with _$SyncInitialised {
  const factory SyncInitialised() = _SyncInitialised;
}

@freezed
class SyncData extends SyncEvent with _$SyncData {
  const factory SyncData({
    required String qrData,
  }) = _SyncData;
}

@freezed
class SyncScanQRCode extends SyncEvent with _$SyncScanQRCode {
  const factory SyncScanQRCode() = _SyncScanQRCode;
}

@freezed
class SyncScanNewPressed extends SyncEvent with _$SyncScanNewPressed {
  const factory SyncScanNewPressed() = _SyncScanNewPressed;
}

@freezed
class SyncCancel extends SyncEvent with _$SyncCancel {
  const factory SyncCancel() = _SyncCancel;
}

@freezed
class LoadDemoData extends SyncEvent with _$LoadDemoData {
  const factory LoadDemoData() = _LoadDemoData;
}

@freezed
class DataHandled extends SyncEvent with _$DataHandled {
  const factory DataHandled({
    required String sourceId,
    required bool isSuccess,
    String? errorMessage,
  }) = _DataHandled;
}

@freezed
class TriggerTutorial extends SyncEvent with _$TriggerTutorial {
  const factory TriggerTutorial() = _TriggerTutorial;
}

@freezed
class ResetTutorial extends SyncEvent with _$ResetTutorial {
  const factory ResetTutorial() = _ResetTutorial;
}

@freezed
class DemoDataConfirmed extends SyncEvent with _$DemoDataConfirmed {
  const factory DemoDataConfirmed() = _DemoDataConfirmed;
}
