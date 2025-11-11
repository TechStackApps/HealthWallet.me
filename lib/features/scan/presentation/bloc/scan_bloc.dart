import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';
import 'package:health_wallet/core/services/pdf_storage_service.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_state.dart';
part 'scan_event.dart';
part 'scan_bloc.freezed.dart';

@Injectable()
class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final PdfStorageService _pdfStorageService;

  ScanBloc(
    this._pdfStorageService,
  ) : super(const ScanState()) {
    on<ScanInitialised>(_onScanInitialised);
    on<ScanButtonPressed>(_onScanButtonPressed);
    on<DeleteDocument>(_onDeleteDocument);
    on<DeletePdf>(_onDeletePdf);
    on<LoadSavedPdfs>(_onLoadSavedPdfs);
    on<DocumentImported>(_onDocumentImported);
    on<ClearScans>(_onClearScans);
    on<ClearImports>(_onClearImports);
  }

  Future<void> _onScanInitialised(
    ScanInitialised event,
    Emitter<ScanState> emit,
  ) async {
    emit(state.copyWith(status: const ScanStatus.initial()));
    add(const LoadSavedPdfs());
  }

  Future<void> _onScanButtonPressed(
    ScanButtonPressed event,
    Emitter<ScanState> emit,
  ) async {
    emit(state.copyWith(status: const ScanStatus.loading()));

    try {
      if (event.mode == ScanMode.pdf) {
        await _handlePdfScan(emit);
      } else {
        await _handleImageScan(event.maxPages, emit);
      }
    } on PlatformException catch (e) {
      final errorMessage = _parsePlatformError(e);
      emit(state.copyWith(
        status: ScanStatus.failure(error: errorMessage),
      ));
    } catch (e) {
      final errorMessage = _parseGeneralError(e);
      emit(state.copyWith(
        status: ScanStatus.failure(error: errorMessage),
      ));
    }
  }

  Future<void> _handlePdfScan(Emitter<ScanState> emit) async {
    final scannedPdf = await FlutterDocScanner().getScannedDocumentAsPdf();

    if (scannedPdf == null || !_isValidScanResult(scannedPdf)) {
      emit(state.copyWith(status: const ScanStatus.initial()));
      return;
    }

    final savedPath = await _pdfStorageService.savePdfToStorage(
      sourcePdfPath: scannedPdf,
      customFileName:
          'health_scan_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );

    if (savedPath != null) {
      final updatedPdfs = [...state.savedPdfPaths, savedPath];
      emit(state.copyWith(
        status: const ScanStatus.success(),
        savedPdfPaths: updatedPdfs,
        lastCreatedPdfPath: savedPath,
      ));
    } else {
      emit(state.copyWith(
        status: const ScanStatus.failure(error: 'Failed to save PDF'),
      ));
    }
  }

  Future<void> _handleImageScan(int maxPages, Emitter<ScanState> emit) async {
    final scannedDocuments =
        await FlutterDocScanner().getScannedDocumentAsImages(
      page: maxPages,
    );

    if (scannedDocuments == null) {
      emit(state.copyWith(status: const ScanStatus.initial()));
      return;
    }

    final imagePaths = _normalizeImagePaths(scannedDocuments);

    if (imagePaths.isEmpty || !_isValidScanResult(imagePaths.first)) {
      emit(state.copyWith(status: const ScanStatus.initial()));
      return;
    }

    final updatedPaths = [...state.scannedImagePaths, ...imagePaths];
    emit(state.copyWith(
      status: const ScanStatus.success(),
      scannedImagePaths: updatedPaths,
    ));
  }

  Future<void> _onDeletePdf(
    DeletePdf event,
    Emitter<ScanState> emit,
  ) async {
    try {
      final success = await _pdfStorageService.deletePdf(event.pdfPath);

      if (success) {
        _removePathFromState(event.pdfPath, emit);
      }
    } catch (e) {
      logger.e('Error deleting PDF: ${event.pdfPath}', e);
    }
  }

  Future<void> _onLoadSavedPdfs(
    LoadSavedPdfs event,
    Emitter<ScanState> emit,
  ) async {
    try {
      final savedPdfs = await _pdfStorageService.getSavedPdfs();
      emit(state.copyWith(savedPdfPaths: savedPdfs));
    } catch (e) {
      logger.e('Error loading saved PDFs', e);
    }
  }

  Future<void> _onDocumentImported(
    DocumentImported event,
    Emitter<ScanState> emit,
  ) async {
    try {
      final file = File(event.filePath);
      final exists = await file.exists();

      if (!exists) {
        emit(state.copyWith(
          status: ScanStatus.failure(error: 'File does not exist'),
        ));
        return;
      }

      if (_isPdfPath(event.filePath)) {
        final updatedPdfs = _addPathToList(
          state.savedPdfPaths,
          event.filePath,
        );
        if (updatedPdfs != null) {
          emit(state.copyWith(
            status: const ScanStatus.success(),
            savedPdfPaths: updatedPdfs,
          ));
        }
      } else {
        final updatedImages = _addPathToList(
          state.importedImagePaths,
          event.filePath,
        );
        if (updatedImages != null) {
          emit(state.copyWith(
            status: const ScanStatus.success(),
            importedImagePaths: updatedImages,
          ));
        }
      }
    } catch (e) {
      logger.e('Error importing document: ${event.filePath}', e);
      emit(state.copyWith(
        status: ScanStatus.failure(error: 'Failed to import document: $e'),
      ));
    }
  }

  Future<void> _onDeleteDocument(
    DeleteDocument event,
    Emitter<ScanState> emit,
  ) async {
    final path = event.imagePath;

    await _safeDeleteFile(path);

    if (_isPdfPath(path) && state.savedPdfPaths.contains(path)) {
      try {
        await _pdfStorageService.deletePdf(path);
      } catch (e) {
        logger.e('Error deleting PDF via storage service: $path', e);
      }
    }

    _removePathFromState(path, emit);
  }

  Future<void> _onClearScans(
    ClearScans event,
    Emitter<ScanState> emit,
  ) async {
    await _deleteFiles(state.scannedImagePaths);
    emit(state.copyWith(scannedImagePaths: []));
  }

  Future<void> _onClearImports(
    ClearImports event,
    Emitter<ScanState> emit,
  ) async {
    await _deleteFiles(state.importedImagePaths);

    for (final pdf in state.savedPdfPaths) {
      try {
        await _pdfStorageService.deletePdf(pdf);
      } catch (e) {
        logger.e('Error deleting PDF during clear imports: $pdf', e);
      }
    }

    emit(state.copyWith(importedImagePaths: [], savedPdfPaths: []));
  }

  Future<void> _safeDeleteFile(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      logger.e('Error deleting file: $path', e);
    }
  }

  Future<void> _deleteFiles(List<String> paths) async {
    for (final path in paths) {
      await _safeDeleteFile(path);
    }
  }

  List<String> _removePathFromList(List<String> list, String path) {
    return list.where((p) => p != path).toList();
  }

  List<String>? _addPathToList(
    List<String> list,
    String path, {
    bool checkDuplicates = true,
  }) {
    if (checkDuplicates && list.contains(path)) {
      return null;
    }
    return [...list, path];
  }

  bool _isPdfPath(String path) {
    return path.toLowerCase().endsWith('.pdf');
  }

  List<String> _normalizeImagePaths(dynamic scannedDocuments) {
    if (scannedDocuments is List) {
      return scannedDocuments.cast<String>();
    } else if (scannedDocuments is String) {
      return [scannedDocuments];
    } else {
      return [scannedDocuments.toString()];
    }
  }

  bool _isValidScanResult(String path) {
    return !path.contains('Failed') && !path.contains('Unknown');
  }

  void _removePathFromState(String path, Emitter<ScanState> emit) {
    if (state.scannedImagePaths.contains(path)) {
      final updated = _removePathFromList(state.scannedImagePaths, path);
      emit(state.copyWith(scannedImagePaths: updated));
    } else if (state.importedImagePaths.contains(path)) {
      final updated = _removePathFromList(state.importedImagePaths, path);
      emit(state.copyWith(importedImagePaths: updated));
    } else if (state.savedPdfPaths.contains(path)) {
      final updated = _removePathFromList(state.savedPdfPaths, path);
      emit(state.copyWith(savedPdfPaths: updated));
    }
  }

  String _parsePlatformError(PlatformException error) {
    final code = error.code.toLowerCase();
    final message = error.message?.toLowerCase() ?? '';

    if (code.contains('permission') || message.contains('permission')) {
      return 'Camera permission is required. Please allow camera access when prompted.';
    } else if (code.contains('cancel') || message.contains('cancel')) {
      return 'Document scanning was cancelled';
    } else if (code.contains('unavailable') ||
        message.contains('unavailable')) {
      return 'Document scanner is not available on this device';
    } else {
      return 'Scanner error: ${error.message ?? 'Unknown error occurred'}';
    }
  }

  String _parseGeneralError(dynamic error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('user') && errorString.contains('cancel')) {
      return 'Document scanning was cancelled';
    } else if (errorString.contains('permission')) {
      return 'Camera permission is required. Please allow camera access.';
    } else if (errorString.contains('camera')) {
      return 'Unable to access camera. Please ensure your camera is working.';
    } else {
      return 'Failed to scan. Please try again.';
    }
  }
}
