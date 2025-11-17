part of 'scan_bloc.dart';

abstract class ScanEvent {
  const ScanEvent();
}

@freezed
class ScanInitialised extends ScanEvent with _$ScanInitialised {
  const factory ScanInitialised() = _ScanInitialised;
}

@freezed
class ScanButtonPressed extends ScanEvent with _$ScanButtonPressed {
  const factory ScanButtonPressed({
    @Default(ScanMode.images) ScanMode mode,
    @Default(5) int maxPages,
  }) = _ScanButtonPressed;
}

@freezed
class DocumentImported extends ScanEvent with _$DocumentImported {
  const factory DocumentImported({
    required String filePath,
  }) = _DocumentImported;
}

@freezed
class ScanSessionChangedProgress extends ScanEvent
    with _$ScanSessionChangedProgress {
  const factory ScanSessionChangedProgress({
    required ProcessingSession session,
  }) = _ScanSessionChangedProgress;
}

@freezed
class ScanSessionFinished extends ScanEvent
    with _$ScanSessionFinished {
  const factory ScanSessionFinished({
    required ProcessingSession session,
  }) = _ScanSessionFinished;
}

enum ScanMode {
  images,
  pdf,
}
