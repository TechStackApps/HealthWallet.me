import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/sync/data/dto/fhir_resource_dto.dart';
import 'package:health_wallet/core/data/local/app_database.dart' as db;
import 'package:health_wallet/features/sync/data/data_source/local/fhir_resource_table.dart';
import 'package:health_wallet/features/sync/domain/entities/source.dart'
    as entity;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FhirLocalDataSource {
  Future<void> cacheFhirResources(List<FhirResourceDto> fhirResources);
  Future<List<FhirResourceDto>> getFhirResources({String? sourceId});
  Future<List<FhirResourceDto>> getEncounterWithReferences(String encounterId);
  Future<void> deleteAllFhirResources();
  Future<String?> getLastSyncTimestamp();
  Future<void> setLastSyncTimestamp(String timestamp);
  Future<void> cacheSources(List<entity.Source> sources);
  Future<List<entity.Source>> getSources({String? patientId});
  Future<void> deleteAllSources();
}

@Injectable(as: FhirLocalDataSource)
class FhirLocalDataSourceImpl implements FhirLocalDataSource {
  final AppDatabase _appDatabase;
  final SharedPreferences _sharedPreferences;

  FhirLocalDataSourceImpl(this._appDatabase, this._sharedPreferences);

  @override
  Future<void> cacheFhirResources(List<FhirResourceDto> fhirResources) async {
    final resources = fhirResources.map((e) {
      final populatedResource = e.populateEncounterIdFromRaw();

      return db.FhirResourceCompanion.insert(
        id: populatedResource.resourceId ?? '',
        sourceId: Value(populatedResource.sourceId),
        resourceType: Value(populatedResource.resourceType),
        resourceId: Value(populatedResource.resourceId),
        title: Value(populatedResource.title),
        date: Value(populatedResource.date),
        resourceRaw: jsonEncode(populatedResource.resourceRaw),
        encounterId: Value(populatedResource.encounterId),
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
  Future<List<FhirResourceDto>> getFhirResources({String? sourceId}) async {
    SimpleSelectStatement<FhirResource, FhirResourceLocalDto> query =
        _appDatabase.select(_appDatabase.fhirResource);

    if (sourceId != null) {
      query.where((tbl) => tbl.sourceId.equals(sourceId));
    }

    final resources = await query.get();

    return resources
        .map(
          (e) => FhirResourceDto(
            id: e.id,
            sourceId: e.sourceId,
            resourceType: e.resourceType,
            resourceId: e.id,
            title: e.title,
            date: e.date,
            resourceRaw: jsonDecode(e.resourceRaw),
            encounterId: e.encounterId,
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteAllFhirResources() {
    return _appDatabase.delete(_appDatabase.fhirResource).go();
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
  Future<void> cacheSources(List<entity.Source> sources) async {
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
  Future<List<entity.Source>> getSources({String? patientId}) async {
    final query = _appDatabase.select(_appDatabase.fhirResource);

    if (patientId != null) {
      query.where((tbl) => tbl.sourceId.equals(patientId));
    } else {
      query.where((tbl) => tbl.sourceId.isNotNull());
    }

    final results = await query.get();
    final uniqueSourceIds = results
        .map((row) => row.sourceId)
        .where((sourceId) => sourceId != null && sourceId!.isNotEmpty)
        .cast<String>()
        .toSet()
        .toList();

    return uniqueSourceIds
        .map(
          (sourceId) => entity.Source(
            id: sourceId,
            name: sourceId,
            logo: null,
          ),
        )
        .toList();
  }

  @override
  Future<List<FhirResourceDto>> getEncounterWithReferences(
      String encounterId) async {
    final resources =
        await _appDatabase.getEncounterWithReferences(encounterId);
    return resources
        .map(
          (e) => FhirResourceDto(
            id: e.id,
            sourceId: e.sourceId,
            resourceType: e.resourceType,
            resourceId: e.id,
            title: e.title,
            date: e.date,
            resourceRaw: jsonDecode(e.resourceRaw),
            encounterId: e.encounterId,
          ),
        )
        .toList();
  }
}
