import 'package:drift/drift.dart';

class WalletHolderConfig extends Table {
  TextColumn get patientId => text()();
  TextColumn get sourceId => text()();
  TextColumn get createdAt => text()();

  @override
  Set<Column> get primaryKey => {patientId};
}
