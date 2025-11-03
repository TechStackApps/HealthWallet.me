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
class DeleteDocument extends ScanEvent with _$DeleteDocument {
  const factory DeleteDocument({
    required String imagePath,
  }) = _DeleteDocument;
}

class ClearScans extends ScanEvent {
  const ClearScans();
}

class ClearImports extends ScanEvent {
  const ClearImports();
}

@freezed
class DeletePdf extends ScanEvent with _$DeletePdf {
  const factory DeletePdf({
    required String pdfPath,
  }) = _DeletePdf;
}

@freezed
class LoadSavedPdfs extends ScanEvent with _$LoadSavedPdfs {
  const factory LoadSavedPdfs() = _LoadSavedPdfs;
}

@freezed
class DocumentImported extends ScanEvent with _$DocumentImported {
  const factory DocumentImported({
    required String filePath,
  }) = _DocumentImported;
}

enum ScanMode {
  images,
  pdf,
}
