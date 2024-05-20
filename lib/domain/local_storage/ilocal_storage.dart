abstract interface class ILocalStorage {
  Future<dynamic> read(String key) async {}
  Future<void> save(String key, data) async {}
}
