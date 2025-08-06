import 'dart:convert';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:drift/drift.dart';
import 'package:health_wallet/features/sync/data/data_source/local/fhir_resource_table.dart';

/// Single datasource for all FHIR resource operations using Drift with optimizations
class FhirResourceDatasource {
  final AppDatabase db;

  FhirResourceDatasource(this.db);

  Future<List<FhirResourceLocalDto>> getResources({
    required List<String> resourceTypes,
    String? sourceId,
    int? limit,
    int? offset,
  }) async {
    SimpleSelectStatement<FhirResource, FhirResourceLocalDto> query =
        db.select(db.fhirResource)..orderBy([(f) => OrderingTerm.desc(f.date)]);

    if (sourceId != null) {
      query.where((f) => f.sourceId.equals(sourceId));
    }

    if (resourceTypes.isNotEmpty) {
      query.where((f) => f.resourceType.isIn(resourceTypes));
    }

    if (limit != null) {
      query.limit(limit, offset: offset);
    }
    
    return await query.get();
  }

  Future<List<FhirResourceLocalDto>> getResourcesByEncounterId({
    required String encounterId,
    String? sourceId,
  }) async {
    SimpleSelectStatement<FhirResource, FhirResourceLocalDto> query = db
        .select(db.fhirResource)
      ..where((f) => f.encounterId.equals(encounterId));

    if (sourceId != null) {
      query.where((f) => f.sourceId.equals(sourceId));
    }

    return await query.get();
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
