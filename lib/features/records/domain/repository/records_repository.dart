import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/entity/record_attachment/record_attachment.dart';
import 'package:health_wallet/features/records/domain/entity/record_note/record_note.dart';

abstract class RecordsRepository {
  Future<List<IFhirResource>> getResources({
    List<FhirType> resourceTypes = const [],
    String? sourceId,
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

  Future<int> addRecordAttachment({
    required String resourceId,
    required String filePath,
  });

  Future<List<RecordAttachment>> getRecordAttachments(String resourceId);

  Future<int> deleteRecordAttachment(RecordAttachment attachment);

  Future<int> addRecordNote({
    required String resourceId,
    required String content,
  });

  Future<List<RecordNote>> getRecordNotes(String resourceId);

  Future<int> editRecordNote(RecordNote note);

  Future<int> deleteRecordNote(RecordNote note);

  Future<void> loadDemoData();

  Future<void> clearDemoData();

  Future<bool> hasDemoData();

  Future<List<IFhirResource>> getBloodTypeObservations({
    required String patientId,
    String? sourceId,
  });

  Future<String> saveObservation(IFhirResource observation);

  Future<void> updatePatient(IFhirResource patient);
}
