import 'dart:convert';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:drift/drift.dart';

/// Single datasource for all FHIR resource operations using Drift with optimizations
class FhirResourceDatasource {
  final AppDatabase db;

  FhirResourceDatasource(this.db);

  /// Get all resources of a specific type with pagination support
  Future<List<Map<String, dynamic>>> getAllResources(
    String resourceType, {
    int? limit,
    int? offset,
    String? sourceId,
  }) async {
    // Handle 'all' resource type - get all resources regardless of type
    if (resourceType == 'all') {
      if (limit != null && offset != null) {
        // Use custom query for pagination with 'all' resources
        final query = db.select(db.fhirResource);

        if (sourceId != null) {
          query.where((tbl) => tbl.sourceId.equals(sourceId));
        }

        query.orderBy([(t) => OrderingTerm.desc(t.date)]);

        final results = await query.get();

        // Apply pagination manually
        final paginatedResults = results.skip(offset).take(limit).toList();

        return paginatedResults
            .map((row) => jsonDecode(row.resourceRaw) as Map<String, dynamic>)
            .toList();
      }

      // For non-paginated queries, get all resources
      final query = db.select(db.fhirResource);

      if (sourceId != null) {
        query.where((tbl) => tbl.sourceId.equals(sourceId));
      }

      query.orderBy([(t) => OrderingTerm.desc(t.date)]);

      final results = await query.get();

      return results
          .map((row) => jsonDecode(row.resourceRaw) as Map<String, dynamic>)
          .toList();
    }

    // Handle specific resource type
    if (limit != null && offset != null) {
      // Use optimized pagination method
      final results = await db.getPaginatedResourcesByType(
        resourceType,
        limit: limit,
        offset: offset,
        sourceId: sourceId,
      );

      return results
          .map((row) => jsonDecode(row.resourceRaw) as Map<String, dynamic>)
          .toList();
    }

    // For non-paginated queries, combine the where conditions properly
    final query = db.select(db.fhirResource);

    if (sourceId != null) {
      query.where((tbl) =>
          tbl.resourceType.equals(resourceType) &
          tbl.sourceId.equals(sourceId));
    } else {
      query.where((tbl) => tbl.resourceType.equals(resourceType));
    }

    query.orderBy([(t) => OrderingTerm.desc(t.date)]);

    final results = await query.get();

    return results
        .map((row) => jsonDecode(row.resourceRaw) as Map<String, dynamic>)
        .toList();
  }

  /// Resolve a FHIR reference (e.g., "Patient/123" or "urn:uuid:...")
  Future<Map<String, dynamic>?> resolveReference(String reference) async {
    // Handle urn:uuid: references
    if (reference.startsWith('urn:uuid:')) {
      final uuid = reference.substring(9); // Remove "urn:uuid:"

      final query = db.select(db.fhirResource)
        ..where((tbl) => tbl.id.equals(uuid))
        ..limit(1);

      final result = await query.getSingleOrNull();
      if (result?.resourceRaw == null) {
        return null;
      }

      return jsonDecode(result!.resourceRaw) as Map<String, dynamic>;
    }

    // Handle ResourceType/id references
    final parts = reference.split('/');
    if (parts.length == 2) {
      final query = db.select(db.fhirResource)
        ..where((tbl) =>
            tbl.resourceType.equals(parts[0]) & tbl.id.equals(parts[1]))
        ..limit(1);

      final result = await query.getSingleOrNull();
      if (result?.resourceRaw == null) {
        return null;
      }

      return jsonDecode(result!.resourceRaw) as Map<String, dynamic>;
    }

    return null;
  }
}
