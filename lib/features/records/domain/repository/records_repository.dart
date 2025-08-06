import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/presentation/models/fhir_resource_display_model.dart';

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
  Future<Map<String, dynamic>?> resolveReference(String reference);

  /// Get display name for a reference (e.g., "Dr. John Smith" for Practitioner)
  Future<String?> getReferenceDisplayName(String reference);
}
