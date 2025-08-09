import 'package:drift/drift.dart';
import 'package:health_wallet/features/sync/data/data_source/local/fhir_resource_table.dart';

@DataClassName('RecordNoteDto')
class RecordNotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get resourceId => text().references(FhirResource, #id)();
  TextColumn get content => text()();
  DateTimeColumn get timestamp => dateTime()();
}