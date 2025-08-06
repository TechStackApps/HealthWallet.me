import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/presentation/models/fhir_resource_display_model.dart';

abstract class RecordsRepository {
  void reset();

  Future<Map<String, List<FhirResourceDisplayModel>>>
      getRelatedResourcesForEncounter(
    String encounterId,
  );

  bool get hasMorePages;

  Future<List<IFhirResource>> getResources({
    List<FhirType> resourceTypes = const [],
    String? sourceId,
    int? limit,
    int? offset,
  });

  /// Get all resources without encounter filtering (for home page counts)
  Future<List<IFhirResource>> getAllResources({
    List<FhirType> resourceTypes = const [],
    String? sourceId,
    int? limit,
    int? offset,
  });

  /// Resolve a FHIR reference to get the actual resource data
  Future<Map<String, dynamic>?> resolveReference(String reference);

  /// Get display name for a reference (e.g., "Dr. John Smith" for Practitioner)
  Future<String?> getReferenceDisplayName(String reference);
}
