import 'package:drift/drift.dart';

class FhirResource extends Table {
  TextColumn get id => text()();
  TextColumn get resourceType => text()();
  TextColumn get resource => text()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  TextColumn get sourceId => text().nullable()();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column> get primaryKey => {id};
}
