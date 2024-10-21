import 'package:get_storage/get_storage.dart';

class CSLocalStorage{
  static final CSLocalStorage _instance = CSLocalStorage._internal();

  factory CSLocalStorage() {
    return _instance;
  }
  CSLocalStorage._internal();

  final _storage = GetStorage();

  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  Future<void> clearAll() async{
    await _storage.erase();
  }
}