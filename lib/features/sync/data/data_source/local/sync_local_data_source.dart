import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:health_wallet/core/data/local/app_database.dart' as db;
import 'package:health_wallet/features/sync/data/dto/fhir_resource_dto.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SyncLocalDataSource {
  Future<void> cacheFhirResources(List<FhirResourceDto> fhirResources);
  Future<void> deleteAllFhirResources();
  Future<String?> getLastSyncTimestamp();
  Future<void> setLastSyncTimestamp(String timestamp);
  Future<void> cacheSources(List<Source> sources);
  Future<List<Source>> getSources({String? patientId});
  Future<void> deleteAllSources();
  Future<void> markResourcesAsDeleted(List<FhirResourceDto> deletions);
  Future<void> updateSourceLabel(String sourceId, String newLabel);
  Future<List<FhirResourceDto>> getAllFhirResources();
}

@Injectable(as: SyncLocalDataSource)
class SyncLocalDataSourceImpl implements SyncLocalDataSource {
  final db.AppDatabase _appDatabase;
  final SharedPreferences _sharedPreferences;

  SyncLocalDataSourceImpl(this._appDatabase, this._sharedPreferences);

  @override
  Future<void> cacheFhirResources(List<FhirResourceDto> fhirResources) async {
    final resources = fhirResources.map((e) {
      return db.FhirResourceCompanion.insert(
        id: e.resourceId ?? '',
        sourceId: Value(e.sourceId),
        resourceType: Value(e.resourceType),
        resourceId: Value(e.resourceId),
        title: Value(e.title),
        date: Value(e.date),
        resourceRaw: jsonEncode(e.resourceRaw),
        encounterId: Value(e.encounterId),
        subjectId: Value(e.subjectId),
        updatedAt: Value(e.updatedAt),
      );
    }).toList();
    await _appDatabase.batch((batch) {
      batch.insertAll(
        _appDatabase.fhirResource,
        resources,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  @override
  Future<void> deleteAllFhirResources() {
    return _appDatabase.delete(_appDatabase.fhirResource).go();
  }

  @override
  Future<List<FhirResourceDto>> getAllFhirResources() async {
    final query = _appDatabase.select(_appDatabase.fhirResource);
    final results = await query.get();
    return results.map((row) {
      return FhirResourceDto(
        id: row.id,
        resourceType: row.resourceType,
        resourceId: row.resourceId,
        sourceId: row.sourceId,
        title: row.title,
        date: row.date,   
        resourceRaw: jsonDecode(row.resourceRaw),
        encounterId: row.encounterId,
        subjectId: row.subjectId,
        updatedAt: row.updatedAt,
      );
    }).toList();
  }

  @override
  Future<String?> getLastSyncTimestamp() {
    return Future.value(_sharedPreferences.getString('lastSyncTimestamp'));
  }

  @override
  Future<void> setLastSyncTimestamp(String timestamp) {
    return _sharedPreferences.setString('lastSyncTimestamp', timestamp);
  }

  @override
  Future<void> cacheSources(List<Source> sources) async {
    final sourceEntries = sources.map((e) {
      return db.SourcesCompanion.insert(
        id: e.id,
        name: Value(e.name),
        logo: Value(e.logo),
      );
    }).toList();
    await _appDatabase.batch((batch) {
      batch.insertAll(
        _appDatabase.sources,
        sourceEntries,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  @override
  Future<void> deleteAllSources() {
    return _appDatabase.delete(_appDatabase.sources).go();
  }

  @override
  Future<List<Source>> getSources({String? patientId}) async {
    // First get unique source IDs from FHIR resources
    final query = _appDatabase.select(_appDatabase.fhirResource);

    if (patientId != null) {
      query.where((tbl) => tbl.sourceId.equals(patientId));
    } else {
      query.where((tbl) => tbl.sourceId.isNotNull());
    }

    final results = await query.get();
    final uniqueSourceIds = results
        .map((row) => row.sourceId)
        .where((sourceId) => sourceId != null && sourceId.isNotEmpty)
        .cast<String>()
        .toSet()
        .toList();

    // Get source labels from Sources table
    final sourceLabels = await _appDatabase.select(_appDatabase.sources).get();
    final sourceLabelMap = {
      for (final source in sourceLabels) source.id: source.labelSource
    };

    return uniqueSourceIds
        .map(
          (sourceId) => Source(
            id: sourceId,
            name: sourceId,
            logo: null,
            labelSource: sourceLabelMap[sourceId] ??
                (sourceId == 'demo_data' ? 'Demo' : null),
          ),
        )
        .toList();
  }

  @override
  Future<void> markResourcesAsDeleted(List<FhirResourceDto> deletions) async {
    // TODO: Implement proper deletion marking when database schema supports it
    // For now, we'll just log the deletions
    for (final deletion in deletions) {
      if (deletion.resourceId != null) {
        // Note: The current database schema doesn't support deletedAt field
        // We would need to either:
        // 1. Add a deletedAt field to the database schema
        // 2. Use an existing field to mark deletion status
        // 3. Remove the resource entirely
      }
    }
  }

  @override
  Future<void> updateSourceLabel(String sourceId, String newLabel) async {
    try {
      await _appDatabase.into(_appDatabase.sources).insertOnConflictUpdate(
            db.SourcesCompanion(
              id: Value(sourceId),
              labelSource: Value(newLabel.isEmpty ? null : newLabel),
            ),
          );
    } catch (e) {
      logger.e('Error updating source label in database: $e');
      rethrow;
    }
  }
}
