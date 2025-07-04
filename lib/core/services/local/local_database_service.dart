import 'package:hive/hive.dart';

class LocalDatabaseService<T> {
  LocalDatabaseService(this.boxName);

  final String boxName;

  Box<T>? _box;

  Future<void> openBox() async {
    if (!Hive.isBoxOpen(boxName)) {
      _box = await Hive.openBox<T>(boxName);
    } else {
      _box = Hive.box<T>(boxName);
    }
  }

   Future<void> closeBox() async {
    if (_box != null) {
      await _box!.close();
      _box = null;
    }
  }

  Box<T> get box {
    if (_box == null) {
      throw StateError('Box $boxName not opened. Call openBox() first.');
    }
    return _box!;
  }

  bool contains(dynamic key) {
    return box.containsKey(key);
  }

  int count() {
    return box.length;
  }

  Future<void> clear() {
    return box.clear();
  }

  Future<void> delete(dynamic key) {
    return box.delete(key);
  }

  List<T> getAll() {
    return box.values.toList();
  }

  T? getFirst() {
    return box.values.firstOrNull;
  }

  T? get(dynamic key) {
    return box.get(key);
  }

  bool isEmpty() {
    return box.isEmpty;
  }

  Future<void> put(dynamic key, T t) {
    return box.put(key, t);
  }
}
