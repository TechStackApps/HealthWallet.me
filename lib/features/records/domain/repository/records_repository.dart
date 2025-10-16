import 'package:flutter/services.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/entity/patient_record/patient_record.dart';
import 'package:health_wallet/features/records/domain/entity/record_attachment/record_attachment.dart';
import 'package:health_wallet/features/records/domain/entity/record_note/record_note.dart';

abstract class RecordsRepository {
  Future<List<IFhirResource>> getResources({
    List<FhirType> resourceTypes = const [],
    String? sourceId,
    List<String>? sourceIds,
    int limit = 20,
    int offset = 0,
  });

  Future<List<IFhirResource>> getRelatedResourcesForEncounter({
    required String encounterId,
    String? sourceId,
  });

  Future<List<IFhirResource>> getRelatedResources({
    required IFhirResource resource,
  });

  Future<IFhirResource?> resolveReference(String reference);

  // Patient Records Management
  Future<PatientRecord> getOrCreatePatientRecord({
    required String patientId,
    String? sourceId,
  });

  Future<List<PatientRecord>> getPatientRecords({
    String? sourceId,
    int limit = 20,
    int offset = 0,
  });

  Future<PatientRecord?> getPatientRecord(String patientId);

  // FHIR-Compliant Record Attachments
  Future<int> addRecordAttachment({
    required String patientRecordId,
    required String mediaId,
    required String contentType,
    String? title,
    int? size,
    Uint8List? data,
    String? filePath,
    String? subjectReference,
    String? encounterReference,
    String? mediaType,
    String? mediaSubtype,
    String? identifierSystem,
    String? identifierValue,
    String? identifierUse,
  });

  Future<List<RecordAttachment>> getRecordAttachments(String patientRecordId);

  Future<int> deleteRecordAttachment(RecordAttachment attachment);

  Future<int> updateRecordAttachment(RecordAttachment attachment);

  // Record Notes (Patient-Centric)
  Future<int> addRecordNote({
    required String patientRecordId,
    required String content,
  });

  Future<List<RecordNote>> getRecordNotes(String patientRecordId);

  Future<int> editRecordNote(RecordNote note);

  Future<int> deleteRecordNote(RecordNote note);

  // Legacy methods for backward compatibility (deprecated)
  @Deprecated('Use addRecordAttachment with patientRecordId instead')
  Future<int> addRecordAttachmentLegacy({
    required String resourceId,
    required String filePath,
  });

  @Deprecated('Use getRecordAttachments with patientRecordId instead')
  Future<List<RecordAttachment>> getRecordAttachmentsLegacy(String resourceId);

  @Deprecated('Use addRecordNote with patientRecordId instead')
  Future<int> addRecordNoteLegacy({
    required String resourceId,
    required String content,
  });

  @Deprecated('Use getRecordNotes with patientRecordId instead')
  Future<List<RecordNote>> getRecordNotesLegacy(String resourceId);

  Future<void> loadDemoData();

  Future<void> clearDemoData();

  Future<bool> hasDemoData();

  Future<List<IFhirResource>> getBloodTypeObservations({
    required String patientId,
    String? sourceId,
  });

  Future<String> saveObservation(IFhirResource observation);

  Future<void> updatePatient(IFhirResource patient);

  Future<List<IFhirResource>> searchResources({
    required String query,
    List<FhirType> resourceTypes = const [],
    String? sourceId,
    int limit = 50,
  });

  Future<Uint8List> buildIpsExport({required String? sourceId});
}
