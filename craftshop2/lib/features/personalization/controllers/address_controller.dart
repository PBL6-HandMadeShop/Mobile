import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/delivery_infor.dart';

class DeliveryController {
  final String _storageKey = 'delivery_info';
  final String _mainDeliveryKey = 'main_delivery';


  // Lưu thông tin giao hàng chính
  Future<void> setMainDelivery(DeliveryInfo info) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(info.toMap());
    await prefs.setString(_mainDeliveryKey, data);
  }

  // Lấy thông tin giao hàng chính
  Future<DeliveryInfo?> getMainDelivery() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_mainDeliveryKey);
    if (data != null) {
      final map = jsonDecode(data);
      return DeliveryInfo.fromMap(map);
    }
    return null;
  }

  // Xóa thông tin giao hàng chính
  Future<void> clearMainDelivery() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_mainDeliveryKey);
  }
  // Lưu thông tin giao hàng
  Future<void> saveDeliveryInfo(DeliveryInfo info) async {
    final prefs = await SharedPreferences.getInstance();
    // Lấy danh sách hiện có từ SharedPreferences
    final data = prefs.getString(_storageKey);
    List<dynamic> existingData = data != null ? jsonDecode(data) : [];

    // Thêm địa chỉ mới
    existingData.add(info.toMap());

    // Lưu danh sách mới
    await prefs.setString(_storageKey, jsonEncode(existingData));
  }
  Future<void> clearInvalidData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_storageKey);
    if (data != null) {
      try {
        final decodedData = jsonDecode(data);
        if (decodedData is Map<String, dynamic>) {
          // Nếu dữ liệu cũ là Map thay vì List, xóa dữ liệu
          print("Invalid data detected, clearing...");
          await prefs.remove(_storageKey);
        }
      } catch (e) {
        print("Error clearing invalid data: $e");
      }
    }
  }
  // Lấy thông tin giao hàng
  Future<DeliveryInfo?> getDeliveryInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_storageKey);
    if (data != null) {
      final map = jsonDecode(data);
      return DeliveryInfo.fromMap(map);
    }
    return null;
  }
  Future<List<DeliveryInfo>> getAddressList() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_storageKey);
    if (data != null) {
      final List<dynamic> list = jsonDecode(data);
      return list.map((item) => DeliveryInfo.fromMap(item)).toList();
    }
    return [];
  }

  // Xóa thông tin giao hàng
  Future<void> clearAllDeliveryInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }

}
