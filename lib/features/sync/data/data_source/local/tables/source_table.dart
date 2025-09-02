import 'package:drift/drift.dart';

class Sources extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  TextColumn get logo => text().nullable()();
  TextColumn get labelSource => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
