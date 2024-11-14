import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/authencation/models/user_model.dart';

class CSLocalStorage {
  static final CSLocalStorage _instance = CSLocalStorage._internal();

  factory CSLocalStorage() {
    return _instance;
  }
  CSLocalStorage._internal();

  final _storage = GetStorage();
  static Future<void> saveUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode(user.toJson());
    await prefs.setString('userData', userData);
    print('User data saved: $userData'); // Debug print to confirm data is saved
  }

  static Future<User?> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    }
    return null;
  }
  static Future<User?> readUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user_data');
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson)); // Decode JSON to User object
    }
    return null;
  }
  // Phương thức lưu dữ liệu vào SharedPreferences
  static Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

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
