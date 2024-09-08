abstract class ILocalStorageCaller {
  Future<bool> saveData({
    required String table,
    required String key,
    required dynamic value,
  });

  Future<dynamic> restoreData({
    required String table,
    required String key,
  });

  Future<bool> deleteKey({
    required String table,
    required String key,
  });

  Future<List<String>> getAllKeys(String table);

  Future<List> getAllValues(String table);

  Future<Map> getAllEntries(String table);

  Future<bool> clearAll({required String table});
}
