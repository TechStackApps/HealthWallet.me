import 'package:drift/drift.dart';
import 'package:health_wallet/features/sync/data/data_source/local/tables/source_table.dart';

@DataClassName('PatientRecordDto')
class PatientRecords extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()(); // References Patient FHIR resource
  TextColumn get sourceId => text().nullable().references(Sources, #id)();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
