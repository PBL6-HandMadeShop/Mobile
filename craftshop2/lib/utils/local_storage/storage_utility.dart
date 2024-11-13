import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CSLocalStorage {
  static final CSLocalStorage _instance = CSLocalStorage._internal();

  factory CSLocalStorage() {
    return _instance;
  }
  CSLocalStorage._internal();

  final _storage = GetStorage();

  // Phương thức lưu dữ liệu vào SharedPreferences
  static Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Phương thức đọc dữ liệu từ SharedPreferences
  static Future<String?> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Phương thức xóa dữ liệu
  static Future<void> removeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // Tạo phương thức getItem để lấy sessionCode
  static Future<String?> getItem(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Phương thức lưu danh mục dưới dạng JSON
  static Future<void> saveCategoriesLocally(List<dynamic> categories) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String categoriesJson = jsonEncode(categories);
    await prefs.setString('categories', categoriesJson);
    print('Categories saved locally');
  }

  // Phương thức tải danh mục từ SharedPreferences
  static Future<List<dynamic>?> loadCategoriesFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? categoriesJson = prefs.getString('categories');
    if (categoriesJson != null) {
      List<dynamic> categoriesList = jsonDecode(categoriesJson);
      print('Categories loaded from local storage');
      return categoriesList;
    } else {
      print('No categories found in local storage');
      return null;
    }
  }

  // Xóa toàn bộ dữ liệu
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
