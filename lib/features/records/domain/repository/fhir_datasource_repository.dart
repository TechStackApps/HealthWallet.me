/// Domain repository interface for low-level FHIR datasource operations
///
/// This interface defines the contract for basic CRUD operations on FHIR resources
/// at the datasource level. It provides a clean abstraction over the data layer.
abstract class FhirDatasourceRepository {
  /// Insert a single FHIR resource
  Future<void> insertResource(
    String resourceType,
    String resourceId,
    Map<String, dynamic> resourceJson,
  );

  /// Bulk insert multiple FHIR resources
  Future<void> bulkInsertResources(
    String resourceType,
    List<Map<String, dynamic>> resources,
  );

  /// Get a resource by type and ID
  Future<Map<String, dynamic>?> getResourceById(
    String resourceType,
    String resourceId,
  );

  /// Get all resources of a specific type
  Future<List<Map<String, dynamic>>> getAllResourcesByType(
    String resourceType,
  );

  /// Get all resources matching multiple types
  Future<List<Map<String, dynamic>>> getAllResourcesByTypes(
    List<String> resourceTypes,
  );

  /// Resolve a FHIR reference (e.g., "Patient/123" -> Patient resource)
  Future<Map<String, dynamic>?> resolveReference(String reference);

  /// Resolve multiple FHIR references at once
  Future<List<Map<String, dynamic>?>> resolveReferences(
      List<String> references);

  /// Get resources that reference a specific resource
  Future<List<Map<String, dynamic>>> getResourcesReferencingResource(
    String resourceType,
    String resourceId,
  );

  /// Delete a resource by type and ID
  Future<void> deleteResource(String resourceType, String resourceId);

  /// Delete all resources of a specific type
  Future<void> deleteAllResourcesByType(String resourceType);

  /// Get resource count by type
  Future<int> getResourceCountByType(String resourceType);

  /// Get all available resource types in the database
  Future<List<String>> getAvailableResourceTypes();

  /// Check if a resource exists
  Future<bool> resourceExists(String resourceType, String resourceId);

  /// Get resources by source ID (for multi-source scenarios)
  Future<List<Map<String, dynamic>>> getResourcesBySource(String sourceId);

  /// Update a resource
  Future<void> updateResource(
    String resourceType,
    String resourceId,
    Map<String, dynamic> resourceJson,
  );
}
