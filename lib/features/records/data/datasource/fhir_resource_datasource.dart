import 'dart:convert';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:drift/drift.dart';
import 'package:health_wallet/features/sync/data/data_source/local/fhir_resource_table.dart';

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
  Future<FhirResourceLocalDto?> resolveReference(String reference) async {
    // Handle urn:uuid: references
    if (reference.startsWith('urn:uuid:')) {
      final uuid = reference.substring(9);

      final query = db.select(db.fhirResource)
        ..where((tbl) => tbl.resourceId.equals(uuid))
        ..limit(1);

      return await query.getSingleOrNull();
    }

    final parts = reference.split('/');
    if (parts.length == 2) {
      final query = db.select(db.fhirResource)
        ..where((tbl) =>
            tbl.resourceType.equals(parts[0]) & tbl.resourceId.equals(parts[1]))
        ..limit(1);

      return await query.getSingleOrNull();
    }

    return null;
  }

  Future<int> addRecordAttachment({
    required String resourceId,
    required String filePath,
  }) async {
    return db.recordAttachments
        .insertOnConflictUpdate(RecordAttachmentsCompanion.insert(
      resourceId: resourceId,
      filePath: filePath,
      timestamp: DateTime.now(),
    ));
  }

  Future<List<RecordAttachmentDto>> getRecordAttachments(
      String resourceId) async {
    return (db.select(db.recordAttachments)
          ..where((f) => f.resourceId.equals(resourceId))
          ..orderBy([(f) => OrderingTerm.desc(f.timestamp)]))
        .get();
  }

  Future<int> deleteRecordAttachment(int id) async {
    return (db.delete(db.recordAttachments)..where((f) => f.id.equals(id)))
        .go();
  }

  Future<int> addRecordNote({
    required String resourceId,
    required String content,
  }) async {
    return db.recordNotes.insertOnConflictUpdate(RecordNotesCompanion.insert(
      resourceId: resourceId,
      content: content,
      timestamp: DateTime.now(),
    ));
  }

  Future<List<RecordNoteDto>> getRecordNotes(String resourceId) async {
    return (db.select(db.recordNotes)
          ..where((f) => f.resourceId.equals(resourceId))
          ..orderBy([(f) => OrderingTerm.desc(f.timestamp)]))
        .get();
  }

  Future<int> updateRecordNote(
      {required int id, required String content}) async {
    return (db.update(db.recordNotes)..where((f) => f.id.equals(id)))
        .write(RecordNotesCompanion(content: Value(content)));
  }

  Future<int> deleteRecordNote(int id) async {
    return (db.delete(db.recordNotes)..where((f) => f.id.equals(id))).go();
  }
}
