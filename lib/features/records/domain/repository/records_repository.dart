import 'package:health_wallet/features/records/presentation/models/encounter_display_model.dart';
import 'package:health_wallet/features/records/presentation/models/fhir_resource_display_model.dart';

/// Domain repository interface for FHIR records operations
///
/// This interface defines the contract for records-related operations
/// following clean architecture principles. It abstracts away data layer
/// implementation details and provides a clear API for the domain layer.
abstract class RecordsRepository {
  /// Import a FHIR Bundle and return summary of imported resources
  Future<Map<String, int>> importFhirBundle(String bundleJson);

  /// Get all encounters ready for UI display with resolved relationships
  Future<List<EncounterDisplayModel>> getEncountersForDisplay();

  /// Get all FHIR resources of specified types ready for UI display
  Future<List<FhirResourceDisplayModel>> getAllResourcesForDisplay({
    List<String>? resourceTypes,
  });

  /// Get standalone resources (non-encounter-related) for display
  Future<List<FhirResourceDisplayModel>> getStandaloneResourcesForDisplay({
    List<String>? resourceTypes,
  });

  /// Get related resources for a specific encounter
  Future<Map<String, List<FhirResourceDisplayModel>>>
      getRelatedResourcesForEncounter(
    String encounterId,
  );

  /// Get all available resource types in the database
  Future<List<String>> getAvailableResourceTypes();

  /// Get resources filtered by multiple criteria
  Future<List<FhirResourceDisplayModel>> getResourcesWithFilters({
    List<String>? resourceTypes,
    DateTime? startDate,
    DateTime? endDate,
    String? patientId,
  });

  /// Search resources by text query
  Future<List<FhirResourceDisplayModel>> searchResources(String query);

  /// Get resource counts by type for analytics/dashboard
  Future<Map<String, int>> getResourceCounts();

  /// Delete all resources for a specific source
  Future<void> deleteResourcesForSource(String sourceId);

  /// Get resources for a specific patient
  Future<List<FhirResourceDisplayModel>> getResourcesForPatient(
      String patientId);
}
