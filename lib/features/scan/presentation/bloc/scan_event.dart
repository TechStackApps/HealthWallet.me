// scan_event.dart
part of 'scan_bloc.dart';

@freezed
class ScanEvent with _$ScanEvent {
  const factory ScanEvent.initialised() = ScanInitialised;

  const factory ScanEvent.scanButtonPressed({
    @Default(ScanMode.images) ScanMode mode,
    @Default(5) int maxPages,
  }) = ScanButtonPressed;

  const factory ScanEvent.deleteDocument({
    required String imagePath,
  }) = DeleteDocument;

  const factory ScanEvent.clearAllDocuments() = ClearAllDocuments;

  const factory ScanEvent.deletePdf({
    required String pdfPath,
  }) = DeletePdf;

  const factory ScanEvent.loadSavedPdfs() = LoadSavedPdfs;

  const factory ScanEvent.documentImported({
    required String filePath,
  }) = DocumentImported;
}

enum ScanMode {
  images, // getScannedDocumentAsImages()
  pdf, // getScannedDocumentAsPdf()
}
