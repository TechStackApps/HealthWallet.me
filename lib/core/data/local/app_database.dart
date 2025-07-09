import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:health_wallet/features/sync/data/data_source/local/fhir_resource_table.dart';
import 'package:health_wallet/features/sync/data/data_source/local/source_table.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [FhirResource, Sources])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
      );

  Stream<List<Source>> watchSources() => select(sources).watch();
  Future<void> addSource(SourcesCompanion entry) => into(sources).insert(entry);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
