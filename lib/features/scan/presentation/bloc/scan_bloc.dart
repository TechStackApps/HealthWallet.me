import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';
import 'package:health_wallet/core/services/pdf_storage_service.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/scan/domain/entity/processing_session.dart';
import 'package:health_wallet/features/scan/domain/repository/scan_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'scan_state.dart';
part 'scan_event.dart';
part 'scan_bloc.freezed.dart';

@LazySingleton()
class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final PdfStorageService _pdfStorageService;
  final ScanRepository _repository;

  ScanBloc(
    this._pdfStorageService,
    this._repository,
  ) : super(const ScanState()) {
    on<ScanInitialised>(_onScanInitialised);
    on<ScanButtonPressed>(_onScanButtonPressed);
    on<DocumentImported>(_onDocumentImported);
    on<ScanSessionChangedProgress>(_onScanSessionChangedProgress);
    on<ScanSessionFinished>(_onScanSessionFinished);
  }

  Future<void> _onScanInitialised(
    ScanInitialised event,
    Emitter<ScanState> emit,
  ) async {
    emit(state.copyWith(status: const ScanStatus.loading()));
    log("got here scan");
      final sessions = await _repository.getProcessingSessions();
      log(sessions.toString());
      emit(state.copyWith(
        sessions: sessions,
        status: const ScanStatus.initial(),
      ));

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

  Future _createSession(
    Emitter<ScanState> emit, {
    required List<String> filePaths,
    required ProcessingOrigin origin,
  }) async {
    final session = await _repository.createProcessingSession(
        filePaths: filePaths, origin: origin);

    emit(state.copyWith(
      status: ScanStatus.sessionCreated(session: session),
      sessions: [session, ...state.sessions],
    ));
  }

  Future<void> _handlePdfScan(Emitter<ScanState> emit) async {
    final scannedPdf = await FlutterDocScanner().getScannedDocumentAsPdf();

    if (scannedPdf == null || !_isValidScanResult(scannedPdf)) {
      emit(state.copyWith(status: const ScanStatus.initial()));
      return;
    }
    log(scannedPdf);
    final savedPath = await _pdfStorageService.savePdfToStorage(
      sourcePdfPath: scannedPdf,
      customFileName:
          'health_scan_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );

    if (savedPath != null) {
      await _createSession(emit,
          filePaths: [savedPath], origin: ProcessingOrigin.scan);
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

    await _createSession(emit,
        filePaths: imagePaths, origin: ProcessingOrigin.scan);
  }

  Future<void> _onDocumentImported(
    DocumentImported event,
    Emitter<ScanState> emit,
  ) async {
    emit(state.copyWith(status: const ScanStatus.loading()));
    try {
      final file = File(event.filePath);
      final exists = await file.exists();

      if (!exists) {
        emit(state.copyWith(
          status: const ScanStatus.failure(error: 'File does not exist'),
        ));
        return;
      }

      log(event.filePath);

      await _createSession(emit,
          filePaths: [event.filePath], origin: ProcessingOrigin.import);
    } catch (e) {
      logger.e('Error importing document: ${event.filePath}', e);
      emit(state.copyWith(
        status: ScanStatus.failure(error: 'Failed to import document: $e'),
      ));
    }
  }

  void _onScanSessionChangedProgress(
    ScanSessionChangedProgress event,
    Emitter<ScanState> emit,
  ) {
    final newSessions = [...state.sessions]
      ..removeWhere((session) => session.id == event.session.id);

    emit(state.copyWith(sessions: [event.session, ...newSessions]));

    if (event.session.status == ProcessingStatus.draft) {
      _repository.editProcessingSession(event.session);
    }
  }

  void _onScanSessionFinished(
    ScanSessionFinished event,
    Emitter<ScanState> emit,
  ) async {
    try {
      final newSessions = [...state.sessions]
        ..removeWhere((session) => session.id == event.session.id);
      emit(state.copyWith(sessions: newSessions));

      await _repository.deleteProcessingSession(event.session);
    } on Exception catch (e) {
      emit(state.copyWith(status: ScanStatus.failure(error: e.toString())));
    }
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
