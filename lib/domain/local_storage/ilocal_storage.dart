abstract interface class ILocalStorage {
  Future<void> delete(String key) async {}
  Future<void> deleteAll() async {}
  Future<dynamic> read(String key) async {}
  Future<void> save(String key, data) async {}
}
