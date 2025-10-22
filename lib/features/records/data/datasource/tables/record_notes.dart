import 'package:drift/drift.dart';
import 'package:health_wallet/features/records/data/datasource/tables/patient_records.dart';

@DataClassName('RecordNoteDto')
class RecordNotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get patientRecordId => text().references(PatientRecords, #id)();
  TextColumn get content => text()();
  DateTimeColumn get timestamp => dateTime()();
}
