import 'package:flickrate/domain/local_storage/ilocal_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage implements ILocalStorage {
  @override
  Future<dynamic> read(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic data = prefs.getString(key);
    return data;
  }

  @override
  Future<void> save(String key, data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }
}
