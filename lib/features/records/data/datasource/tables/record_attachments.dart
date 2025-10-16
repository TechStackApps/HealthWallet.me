import 'package:drift/drift.dart';
import 'package:health_wallet/features/records/data/datasource/tables/patient_records.dart';

@DataClassName('RecordAttachmentDto')
class RecordAttachments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get patientRecordId => text().references(PatientRecords, #id)();

  // FHIR Media Resource Fields
  TextColumn get mediaId => text()();
  TextColumn get status => text().withDefault(const Constant('completed'))();
  TextColumn get contentType => text()();
  TextColumn get title => text().nullable()();
  IntColumn get size => integer().nullable()();
  BlobColumn get data => blob().nullable()(); // Base64 encoded data
  TextColumn get filePath => text().nullable()(); // Local file path

  // FHIR References
  TextColumn get subjectReference => text().nullable()();
  TextColumn get encounterReference => text().nullable()();

  // FHIR Media Type Classification
  TextColumn get mediaType => text().withDefault(const Constant('document'))();
  TextColumn get mediaSubtype => text().nullable()();

  // FHIR Identifiers
  TextColumn get identifierSystem => text().nullable()();
  TextColumn get identifierValue => text().nullable()();
  TextColumn get identifierUse => text().withDefault(const Constant('usual'))();

  // Metadata
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
