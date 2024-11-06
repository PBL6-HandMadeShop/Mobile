import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CSLocalStorage{
  static final CSLocalStorage _instance = CSLocalStorage._internal();

  factory CSLocalStorage() {
    return _instance;
  }
  CSLocalStorage._internal();

  final _storage = GetStorage();

  static Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  Future<void> clearAll() async{
    await _storage.erase();
  }
}