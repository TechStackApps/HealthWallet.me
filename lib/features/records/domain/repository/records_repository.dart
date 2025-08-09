import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/entity/record_attachment/record_attachment.dart';

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

  /// Resolve a FHIR reference to get the actual resource data
  Future<IFhirResource?> resolveReference(String reference);

  Future<int> addRecordAttachment({
    required String resourceId,
    required String filePath,
  });

  Future<List<RecordAttachment>> getRecordAttachments(String resourceId);

  Future<int> deleteRecordAttachment(RecordAttachment attachment);
}
