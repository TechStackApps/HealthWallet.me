import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/entity/record_attachment/record_attachment.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/features/sync/domain/services/source_type_service.dart';
import 'package:health_wallet/features/sync/domain/repository/sync_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'record_attachments_event.dart';
part 'record_attachments_state.dart';
part 'record_attachments_bloc.freezed.dart';

@injectable
class RecordAttachmentsBloc
    extends Bloc<RecordAttachmentsEvent, RecordAttachmentsState> {
  RecordAttachmentsBloc(
    this._recordsRepository,
    this._sourceTypeService,
    this._syncRepository,
  ) : super(const RecordAttachmentsState()) {
    on<RecordAttachmentsInitialised>(_onRecordAttachmentsInitialised);
    on<RecordAttachmentsFileAttached>(_onRecordAttachmentsFileAttached);
    on<RecordAttachmentsFileDeleted>(_onRecordAttachmentsFileDeleted);
  }

  final RecordsRepository _recordsRepository;
  final SourceTypeService _sourceTypeService;
  final SyncRepository _syncRepository;

  _onRecordAttachmentsInitialised(
    RecordAttachmentsInitialised event,
    Emitter<RecordAttachmentsState> emit,
  ) async {
    emit(state.copyWith(status: const RecordAttachmentsStatus.loading()));

    try {
      // Extract subjectId from the raw FHIR resource
      final subjectId = _extractSubjectId(event.resource);

      // Determine the appropriate source for creating patient records
      final effectiveSourceId = await _getEffectiveSourceId(
        resourceSourceId: event.resource.sourceId,
        patientId: subjectId ?? '',
      );

      // Get or create patient record for this resource
      final patientRecord = await _recordsRepository.getOrCreatePatientRecord(
        patientId: subjectId ?? '',
        sourceId: effectiveSourceId,
      );

      // Get attachments for this patient record
      List<RecordAttachment> attachments =
          await _recordsRepository.getRecordAttachments(patientRecord.id);

      emit(state.copyWith(
          attachments: attachments,
          resource: event.resource,
          status: const RecordAttachmentsStatus.success()));
    } catch (e) {
      emit(state.copyWith(status: RecordAttachmentsStatus.error(e)));
    }
  }

  _onRecordAttachmentsFileAttached(
    RecordAttachmentsFileAttached event,
    Emitter<RecordAttachmentsState> emit,
  ) async {
    emit(state.copyWith(status: const RecordAttachmentsStatus.loading()));

    try {
      Directory appDirectory = await getApplicationDocumentsDirectory();

      String originalFileName = basename(event.file.path);
      String newFilePath = join(appDirectory.path, originalFileName);

      await event.file.copy(newFilePath);

      // Extract subjectId from the raw FHIR resource
      final subjectId = _extractSubjectId(state.resource);

      // Determine the appropriate source for creating patient records
      final effectiveSourceId = await _getEffectiveSourceId(
        resourceSourceId: state.resource.sourceId,
        patientId: subjectId ?? '',
      );

      // Get or create patient record for this resource
      final patientRecord = await _recordsRepository.getOrCreatePatientRecord(
        patientId: subjectId ?? '',
        sourceId: effectiveSourceId,
      );

      // Create FHIR-compliant attachment
      await _recordsRepository.addRecordAttachment(
        patientRecordId: patientRecord.id,
        mediaId: 'media_${DateTime.now().millisecondsSinceEpoch}',
        contentType: _getContentTypeFromPath(newFilePath),
        title: originalFileName,
        size: await event.file.length(),
        filePath: newFilePath,
        subjectReference: subjectId != null ? 'Patient/$subjectId' : null,
        encounterReference: _extractEncounterId(state.resource) != null
            ? 'Encounter/${_extractEncounterId(state.resource)}'
            : null,
        mediaType: 'document',
        mediaSubtype: 'medical-document',
        identifierSystem: 'http://health-wallet.app/media-id',
        identifierValue: 'manual_${DateTime.now().millisecondsSinceEpoch}',
        identifierUse: 'usual',
      );

      emit(state.copyWith(attachments: []));
      add(RecordAttachmentsInitialised(resource: state.resource));
    } catch (e) {
      emit(state.copyWith(status: RecordAttachmentsStatus.error(e)));
    }
  }

  /// Get content type from file path
  String _getContentTypeFromPath(String filePath) {
    final extension = filePath.toLowerCase().split('.').last;
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'pdf':
        return 'application/pdf';
      case 'doc':
      case 'docx':
        return 'application/msword';
      case 'txt':
        return 'text/plain';
      default:
        return 'application/octet-stream';
    }
  }

  _onRecordAttachmentsFileDeleted(
    RecordAttachmentsFileDeleted event,
    Emitter<RecordAttachmentsState> emit,
  ) async {
    emit(state.copyWith(status: const RecordAttachmentsStatus.loading()));

    try {
      await _recordsRepository.deleteRecordAttachment(event.attachment);

      event.attachment.file?.delete().ignore();

      add(RecordAttachmentsInitialised(resource: state.resource));
    } catch (e) {
      emit(state.copyWith(status: RecordAttachmentsStatus.error(e)));
    }
  }

  /// Extract subjectId from FHIR resource
  String? _extractSubjectId(IFhirResource resource) {
    final rawResource = resource.rawResource;

    // For Patient resources, subjectId is their own resourceId
    if (resource.fhirType == FhirType.Patient) {
      return resource.resourceId;
    }

    // For other resources, extract from subject reference
    if (rawResource['subject']?['reference'] != null) {
      final reference = rawResource['subject']['reference'] as String;
      // Extract ID from reference like "Patient/123" or "urn:uuid:abc123"
      if (reference.startsWith('Patient/')) {
        return reference.substring(8);
      } else if (reference.startsWith('urn:uuid:')) {
        return reference.substring(9);
      }
    }

    return null;
  }

  /// Extract encounterId from FHIR resource
  String? _extractEncounterId(IFhirResource resource) {
    final rawResource = resource.rawResource;

    // For Encounter resources, encounterId is their own resourceId
    if (resource.fhirType == FhirType.Encounter) {
      return resource.resourceId;
    }

    // For other resources, extract from encounter reference
    if (rawResource['encounter']?['reference'] != null) {
      final reference = rawResource['encounter']['reference'] as String;
      // Extract ID from reference like "Encounter/123" or "urn:uuid:abc123"
      if (reference.startsWith('Encounter/')) {
        return reference.substring(10);
      } else if (reference.startsWith('urn:uuid:')) {
        return reference.substring(9);
      }
    }

    return null;
  }

  /// Determines the effective source ID for creating patient records
  /// If the resource's source is read-only, returns a wallet source ID
  Future<String> _getEffectiveSourceId({
    required String resourceSourceId,
    required String patientId,
  }) async {
    // Get all available sources
    final allSources = await _syncRepository.getSources();

    // Find the resource's source
    final resourceSource = allSources
        .where(
          (s) => s.id == resourceSourceId,
        )
        .firstOrNull;

    // If source is not found or is read-only, use wallet source
    if (resourceSource == null ||
        !_sourceTypeService.isSourceWritable(resourceSource.platformType)) {
      // Get or create wallet source for this patient
      final walletSource = await _sourceTypeService.getWritableSourceForPatient(
        patientId: patientId,
        patientName: null,
        availableSources: allSources,
      );
      return walletSource.id;
    }

    // Source is writable, use it
    return resourceSourceId;
  }
}
