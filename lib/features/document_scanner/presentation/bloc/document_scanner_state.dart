part of 'document_scanner_bloc.dart';

@freezed
class DocumentScannerStatus with _$DocumentScannerStatus {
  const factory DocumentScannerStatus.initial() = Initial;
  const factory DocumentScannerStatus.loading() = Loading;
  const factory DocumentScannerStatus.success() = Success;
  const factory DocumentScannerStatus.failure({required String error}) = Failure;
}

@freezed
class DocumentScannerState with _$DocumentScannerState {
  const factory DocumentScannerState({
    @Default(DocumentScannerStatus.initial()) DocumentScannerStatus status,
    @Default([]) List<String> scannedImagePaths,
    @Default([]) List<String> savedPdfPaths,
    String? lastCreatedPdfPath,
  }) = _DocumentScannerState;
}