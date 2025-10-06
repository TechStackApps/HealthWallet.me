import 'package:drift/drift.dart';

class Sources extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  TextColumn get logo => text().nullable()();
  TextColumn get labelSource => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
