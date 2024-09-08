import 'package:hive/hive.dart';

import 'local_storage_manager.dart';

class HiveLocalStorageCaller implements ILocalStorageCaller {
  @override
  Future<bool> saveData({
    required String table,
    required String key,
    required value,
  }) async {
    try {
      await Hive.openBox(table);
      Box box = Hive.box(table);
      box.put(key, value);
      return box.get(key) != null;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<dynamic> restoreData(
      {required String? table, required String key}) async {
    if (table == null) {
      return null;
    }
    await Hive.openBox(table);
    try {
      Box box = Hive.box(table);
      return box.get(key);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> clearAll({required String table}) async {
    final box = await Hive.openBox(table);
    return (await box.clear()) > 0;
  }

  @override
  Future<Map> getAllEntries(String table) async {
    final box = await Hive.openBox(table);
    return Map.fromIterables(box.keys, box.values);
  }

  @override
  Future<List<String>> getAllKeys(String table) async {
    final box = await Hive.openBox(table);
    return box.keys.map((e) => e.toString()).toList();
  }

  @override
  Future<List> getAllValues(String table) async {
    final box = await Hive.openBox(table);
    return box.values.toList();
  }

  @override
  Future<bool> deleteKey({required String table, required String key}) async {
    final box = await Hive.openBox(table);
    await box.delete(key);

    return box.get(key) == null;
  }
}
