import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';
import 'package:health_wallet/core/services/pdf_storage_service.dart';
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
        final scannedPdf = await FlutterDocScanner().getScannedDocumentAsPdf();

        if (scannedPdf != null &&
            !scannedPdf.contains('Failed') &&
            !scannedPdf.contains('Unknown')) {
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
        } else {
          emit(state.copyWith(status: const ScanStatus.initial()));
        }
      } else {
        final scannedDocuments =
            await FlutterDocScanner().getScannedDocumentAsImages(
          page: event.maxPages,
        );

        if (scannedDocuments != null) {
          List<String> imagePaths = [];

          if (scannedDocuments is List) {
            imagePaths = scannedDocuments.cast<String>();
          } else if (scannedDocuments is String) {
            imagePaths = [scannedDocuments];
          } else {
            imagePaths = [scannedDocuments.toString()];
          }

          if (imagePaths.isNotEmpty &&
              !imagePaths.first.contains('Failed') &&
              !imagePaths.first.contains('Unknown')) {
            final updatedPaths = [...state.scannedImagePaths, ...imagePaths];

            emit(state.copyWith(
              status: const ScanStatus.success(),
              scannedImagePaths: updatedPaths,
            ));
          } else {
            emit(state.copyWith(status: const ScanStatus.initial()));
          }
        } else {
          emit(state.copyWith(status: const ScanStatus.initial()));
        }
      }
    } on PlatformException catch (e) {
      String errorMessage = _parsePlatformError(e);
      emit(state.copyWith(
        status: ScanStatus.failure(error: errorMessage),
      ));
    } catch (e) {
      String errorMessage = _parseGeneralError(e);
      emit(state.copyWith(
        status: ScanStatus.failure(error: errorMessage),
      ));
    }
  }

  Future<void> _onDeletePdf(
    DeletePdf event,
    Emitter<ScanState> emit,
  ) async {
    try {
      final success = await _pdfStorageService.deletePdf(event.pdfPath);

      if (success) {
        final updatedPdfs =
            state.savedPdfPaths.where((path) => path != event.pdfPath).toList();

        emit(state.copyWith(savedPdfPaths: updatedPdfs));
      }
    } catch (e) {}
  }

  Future<void> _onLoadSavedPdfs(
    LoadSavedPdfs event,
    Emitter<ScanState> emit,
  ) async {
    try {
      final savedPdfs = await _pdfStorageService.getSavedPdfs();
      emit(state.copyWith(savedPdfPaths: savedPdfs));
    } catch (e) {}
  }

  Future<void> _onDocumentImported(
    DocumentImported event,
    Emitter<ScanState> emit,
  ) async {
    try {
      final file = File(event.filePath);
      if (await file.exists()) {
        final lowerPath = event.filePath.toLowerCase();
        if (lowerPath.endsWith('.pdf')) {
          final updatedPdfs = [...state.savedPdfPaths, event.filePath];
          emit(state.copyWith(
            status: const ScanStatus.success(),
            savedPdfPaths: updatedPdfs,
          ));
        } else {
          final updatedImportedImages = [
            ...state.importedImagePaths,
            event.filePath
          ];
          emit(state.copyWith(
            status: const ScanStatus.success(),
            importedImagePaths: updatedImportedImages,
          ));
        }
      } else {
        emit(state.copyWith(
          status: ScanStatus.failure(error: 'File does not exist'),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ScanStatus.failure(error: 'Failed to import document: $e'),
      ));
    }
  }

  Future<void> _onDeleteDocument(
    DeleteDocument event,
    Emitter<ScanState> emit,
  ) async {
    try {
      final file = File(event.imagePath);
      if (await file.exists()) {
        await file.delete();
      }

      if (state.scannedImagePaths.contains(event.imagePath)) {
        final updated =
            state.scannedImagePaths.where((p) => p != event.imagePath).toList();
        emit(state.copyWith(scannedImagePaths: updated));
        return;
      }

      if (state.importedImagePaths.contains(event.imagePath)) {
        final updated = state.importedImagePaths
            .where((p) => p != event.imagePath)
            .toList();
        emit(state.copyWith(importedImagePaths: updated));
        return;
      }

      if (state.savedPdfPaths.contains(event.imagePath)) {
        try {
          await _pdfStorageService.deletePdf(event.imagePath);
        } catch (e) {}
        final updated =
            state.savedPdfPaths.where((p) => p != event.imagePath).toList();
        emit(state.copyWith(savedPdfPaths: updated));
        return;
      }
    } catch (e) {
      if (state.scannedImagePaths.contains(event.imagePath)) {
        final updated =
            state.scannedImagePaths.where((p) => p != event.imagePath).toList();
        emit(state.copyWith(scannedImagePaths: updated));
      } else if (state.importedImagePaths.contains(event.imagePath)) {
        final updated = state.importedImagePaths
            .where((p) => p != event.imagePath)
            .toList();
        emit(state.copyWith(importedImagePaths: updated));
      } else if (state.savedPdfPaths.contains(event.imagePath)) {
        final updated =
            state.savedPdfPaths.where((p) => p != event.imagePath).toList();
        emit(state.copyWith(savedPdfPaths: updated));
      }
    }
  }

  Future<void> _onClearScans(
    ClearScans event,
    Emitter<ScanState> emit,
  ) async {
    try {
      for (final path in state.scannedImagePaths) {
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
        }
      }
    } catch (e) {}

    emit(state.copyWith(scannedImagePaths: []));
  }

  Future<void> _onClearImports(
    ClearImports event,
    Emitter<ScanState> emit,
  ) async {
    try {
      for (final path in state.importedImagePaths) {
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
        }
      }
    } catch (e) {}

    try {
      for (final pdf in state.savedPdfPaths) {
        try {
          await _pdfStorageService.deletePdf(pdf);
        } catch (e) {}
      }
    } catch (e) {}

    emit(state.copyWith(importedImagePaths: [], savedPdfPaths: []));
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
