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
  Future<void> deleteAllFhirResources();
  Future<String?> getLastSyncTimestamp();
  Future<void> setLastSyncTimestamp(String timestamp);
  Future<void> cacheSources(List<entity.Source> sources);
  Future<List<entity.Source>> getSources();
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
  Future<List<entity.Source>> getSources() async {
    final sources = await _appDatabase.select(_appDatabase.sources).get();
    return sources
        .map(
          (e) => entity.Source(
            id: e.id,
            name: e.name,
            logo: e.logo,
          ),
        )
        .toList();
  }
}
