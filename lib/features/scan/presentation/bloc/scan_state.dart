part of 'scan_bloc.dart';

@freezed
class ScanStatus with _$ScanStatus {
  const factory ScanStatus.initial() = Initial;
  const factory ScanStatus.loading() = Loading;
  const factory ScanStatus.success() = Success;
  const factory ScanStatus.failure({required String error}) = Failure;
}

@freezed
class ScanState with _$ScanState {
  const factory ScanState({
    @Default(ScanStatus.initial()) ScanStatus status,
    @Default([]) List<String> scannedImagePaths,
    @Default([]) List<String> savedPdfPaths,
    @Default([]) List<String> importedImagePaths,
    String? lastCreatedPdfPath,
  }) = _ScanState;
}
