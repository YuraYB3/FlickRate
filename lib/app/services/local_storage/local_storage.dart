import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/local_storage/ilocal_storage.dart';

class LocalStorage implements ILocalStorage {
  @override
  Future<void> delete(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  @override
  Future<void> deleteAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Future<String> read(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString(key) ?? '';
    return data;
  }

  @override
  Future<void> save(String key, data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }
}
