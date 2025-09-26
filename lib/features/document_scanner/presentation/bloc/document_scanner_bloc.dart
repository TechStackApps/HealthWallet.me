// Updated document scanner bloc with PDF storage
import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';
import 'package:health_wallet/core/services/pdf_storage_service.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_scanner_state.dart';
part 'document_scanner_event.dart';
part 'document_scanner_bloc.freezed.dart';

@Injectable()
class DocumentScannerBloc
    extends Bloc<DocumentScannerEvent, DocumentScannerState> {
  final PdfStorageService _pdfStorageService;

  DocumentScannerBloc(
    this._pdfStorageService,
  ) : super(const DocumentScannerState()) {
    on<DocumentScannerInitialised>(_onDocumentScannerInitialised);
    on<ScanButtonPressed>(_onScanButtonPressed);
    on<DeleteDocument>(_onDeleteDocument);
    on<ClearAllDocuments>(_onClearAllDocuments);
    on<DeletePdf>(_onDeletePdf);
    on<LoadSavedPdfs>(_onLoadSavedPdfs);
    on<DocumentImported>(_onDocumentImported);
  }

  Future<void> _onDocumentScannerInitialised(
    DocumentScannerInitialised event,
    Emitter<DocumentScannerState> emit,
  ) async {
    emit(state.copyWith(status: const DocumentScannerStatus.initial()));
    add(const DocumentScannerEvent.loadSavedPdfs());
  }

  Future<void> _onScanButtonPressed(
    ScanButtonPressed event,
    Emitter<DocumentScannerState> emit,
  ) async {
    emit(state.copyWith(status: const DocumentScannerStatus.loading()));

    try {
      if (event.mode == ScanMode.pdf) {
        // Scan as PDF
        final scannedPdf = await FlutterDocScanner().getScannedDocumentAsPdf();

        if (scannedPdf != null &&
            !scannedPdf.contains('Failed') &&
            !scannedPdf.contains('Unknown')) {
          // Save PDF to permanent storage
          final savedPath = await _pdfStorageService.savePdfToStorage(
            sourcePdfPath: scannedPdf,
            customFileName:
                'health_document_${DateTime.now().millisecondsSinceEpoch}.pdf',
          );

          if (savedPath != null) {
            final updatedPdfs = [...state.savedPdfPaths, savedPath];

            emit(state.copyWith(
              status: const DocumentScannerStatus.success(),
              savedPdfPaths: updatedPdfs,
              lastCreatedPdfPath: savedPath,
            ));
          } else {
            emit(state.copyWith(
              status: const DocumentScannerStatus.failure(
                  error: 'Failed to save PDF'),
            ));
          }
        } else {
          emit(state.copyWith(status: const DocumentScannerStatus.initial()));
        }
      } else {
        // Scan as images (existing functionality)
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
              status: const DocumentScannerStatus.success(),
              scannedImagePaths: updatedPaths,
            ));
          } else {
            emit(state.copyWith(status: const DocumentScannerStatus.initial()));
          }
        } else {
          emit(state.copyWith(status: const DocumentScannerStatus.initial()));
        }
      }
    } on PlatformException catch (e) {
      String errorMessage = _parsePlatformError(e);
      emit(state.copyWith(
        status: DocumentScannerStatus.failure(error: errorMessage),
      ));
    } catch (e) {
      String errorMessage = _parseGeneralError(e);
      emit(state.copyWith(
        status: DocumentScannerStatus.failure(error: errorMessage),
      ));
    }
  }

  Future<void> _onDeletePdf(
    DeletePdf event,
    Emitter<DocumentScannerState> emit,
  ) async {
    try {
      final success = await _pdfStorageService.deletePdf(event.pdfPath);

      if (success) {
        final updatedPdfs =
            state.savedPdfPaths.where((path) => path != event.pdfPath).toList();

        emit(state.copyWith(savedPdfPaths: updatedPdfs));
      }
    } catch (e) {
      print('Failed to delete PDF: $e');
    }
  }

  Future<void> _onLoadSavedPdfs(
    LoadSavedPdfs event,
    Emitter<DocumentScannerState> emit,
  ) async {
    try {
      final savedPdfs = await _pdfStorageService.getSavedPdfs();
      emit(state.copyWith(savedPdfPaths: savedPdfs));
    } catch (e) {
      print('Failed to load saved PDFs: $e');
    }
  }

  Future<void> _onDocumentImported(
    DocumentImported event,
    Emitter<DocumentScannerState> emit,
  ) async {
    try {
      final file = File(event.filePath);
      if (await file.exists()) {
        // Check if it's a PDF or image and store appropriately
        final fileName = event.filePath.toLowerCase();

        if (fileName.endsWith('.pdf')) {
          // Handle PDF import - store in savedPdfPaths for display
          final updatedPdfs = [...state.savedPdfPaths, event.filePath];
          emit(state.copyWith(
            status: const DocumentScannerStatus.success(),
            savedPdfPaths: updatedPdfs,
          ));
        } else {
          // Handle image import - store in scannedImagePaths
          final updatedPaths = [...state.scannedImagePaths, event.filePath];
          emit(state.copyWith(
            status: const DocumentScannerStatus.success(),
            scannedImagePaths: updatedPaths,
          ));
        }
      } else {
        emit(state.copyWith(
          status: DocumentScannerStatus.failure(error: 'File does not exist'),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: DocumentScannerStatus.failure(
            error: 'Failed to import document: $e'),
      ));
    }
  }

  Future<void> _onDeleteDocument(
    DeleteDocument event,
    Emitter<DocumentScannerState> emit,
  ) async {
    try {
      final file = File(event.imagePath);
      if (await file.exists()) {
        await file.delete();
      }

      final updatedPaths = state.scannedImagePaths
          .where((path) => path != event.imagePath)
          .toList();

      emit(state.copyWith(scannedImagePaths: updatedPaths));
    } catch (e) {
      final updatedPaths = state.scannedImagePaths
          .where((path) => path != event.imagePath)
          .toList();

      emit(state.copyWith(scannedImagePaths: updatedPaths));
    }
  }

  Future<void> _onClearAllDocuments(
    ClearAllDocuments event,
    Emitter<DocumentScannerState> emit,
  ) async {
    try {
      for (final imagePath in state.scannedImagePaths) {
        try {
          final file = File(imagePath);
          if (await file.exists()) {
            await file.delete();
          }
        } catch (e) {
          print('Failed to delete file $imagePath: $e');
        }
      }

      emit(state.copyWith(scannedImagePaths: []));
    } catch (e) {
      emit(state.copyWith(scannedImagePaths: []));
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
      return 'Failed to scan document. Please try again.';
    }
  }
}
