import 'dart:convert';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:drift/drift.dart';

class FhirResourceDatasource {
  final AppDatabase db;

  FhirResourceDatasource(this.db);

  Future<List<Map<String, dynamic>>> getAllResources(
    String resourceType, {
    int? limit,
    int? offset,
    String? sourceId,
  }) async {
    if (resourceType == 'all') {
      if (limit != null && offset != null) {
        final query = db.select(db.fhirResource);

        if (sourceId != null) {
          query.where((tbl) => tbl.sourceId.equals(sourceId));
        }

        query.orderBy([(t) => OrderingTerm.desc(t.date)]);

        final results = await query.get();

        final paginatedResults = results.skip(offset).take(limit).toList();

        return paginatedResults.map((row) {
          final resourceData =
              jsonDecode(row.resourceRaw) as Map<String, dynamic>;
          // Add database metadata to the resource data
          resourceData['sourceId'] = row.sourceId;
          resourceData['resourceId'] = row.resourceId;
          resourceData['title'] = row.title;
          resourceData['date'] = row.date?.toIso8601String();
          resourceData['encounterId'] = row.encounterId;
          return resourceData;
        }).toList();
      }

      final query = db.select(db.fhirResource);

      if (sourceId != null) {
        query.where((tbl) => tbl.sourceId.equals(sourceId));
      }

      query.orderBy([(t) => OrderingTerm.desc(t.date)]);

      final results = await query.get();

      return results.map((row) {
        final resourceData =
            jsonDecode(row.resourceRaw) as Map<String, dynamic>;
        // Add database metadata to the resource data
        resourceData['sourceId'] = row.sourceId;
        resourceData['resourceId'] = row.resourceId;
        resourceData['title'] = row.title;
        resourceData['date'] = row.date?.toIso8601String();
        resourceData['encounterId'] = row.encounterId;
        return resourceData;
      }).toList();
    } else {
      // Handle specific resource type (like 'Patient')
      final query = db.select(db.fhirResource);
      query.where((tbl) => tbl.resourceType.equals(resourceType));

      if (sourceId != null) {
        query.where((tbl) => tbl.sourceId.equals(sourceId));
      }

      query.orderBy([(t) => OrderingTerm.desc(t.date)]);

      final results = await query.get();

      return results.map((row) {
        final resourceData =
            jsonDecode(row.resourceRaw) as Map<String, dynamic>;
        // Add database metadata to the resource data
        resourceData['sourceId'] = row.sourceId;
        resourceData['resourceId'] = row.resourceId;
        resourceData['title'] = row.title;
        resourceData['date'] = row.date?.toIso8601String();
        resourceData['encounterId'] = row.encounterId;
        return resourceData;
      }).toList();
    }
  }

  Future<Map<String, dynamic>?> resolveReference(String reference) async {
    if (reference.startsWith('urn:uuid:')) {
      final uuid = reference.substring(9);

      final query = db.select(db.fhirResource)
        ..where((tbl) => tbl.id.equals(uuid))
        ..limit(1);

      final result = await query.getSingleOrNull();
      if (result?.resourceRaw == null) {
        return null;
      }

      return jsonDecode(result!.resourceRaw) as Map<String, dynamic>;
    }

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
