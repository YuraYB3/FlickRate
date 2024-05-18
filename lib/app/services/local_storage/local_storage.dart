import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future<String> read(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString(key) ?? '';
    return data;
  }

  Future<void> save(String key, data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }
}
