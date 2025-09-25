// document_scanner_event.dart
part of 'document_scanner_bloc.dart';

@freezed
class DocumentScannerEvent with _$DocumentScannerEvent {
  const factory DocumentScannerEvent.initialised() = DocumentScannerInitialised;

  const factory DocumentScannerEvent.scanButtonPressed({
    @Default(ScanMode.images) ScanMode mode,
    @Default(5) int maxPages,
  }) = ScanButtonPressed;

  const factory DocumentScannerEvent.deleteDocument({
    required String imagePath,
  }) = DeleteDocument;

  const factory DocumentScannerEvent.clearAllDocuments() = ClearAllDocuments;

  const factory DocumentScannerEvent.deletePdf({
    required String pdfPath,
  }) = DeletePdf;

  const factory DocumentScannerEvent.loadSavedPdfs() = LoadSavedPdfs;

  const factory DocumentScannerEvent.documentImported({
    required String filePath,
  }) = DocumentImported;
}

enum ScanMode {
  images, // getScannedDocumentAsImages()
  pdf, // getScannedDocumentAsPdf()
}
