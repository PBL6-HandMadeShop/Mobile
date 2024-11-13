import 'package:craftshop2/features/authencation/models/user_model.dart';

import 'package:craftshop2/features/authencation/controllers/connect_api/api_service.dart';


import '../../../utils/locators/locator.dart';

class UserController {
  final API_Services apiService = locator<API_Services>();  // Lấy instance từ GetIt

  // Hàm lấy thông tin người dùng
  Future<User> getUserInfo() async {
    try {
      final response = await apiService.getUserInfo();
      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        return User.fromJson(response.data['content']);
      } else {
        throw Exception('Lỗi khi lấy thông tin người dùng: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Lỗi khi gọi API: $e');
    }
  }

  // Hàm cập nhật thông tin người dùng
  Future<User> updateUserInfo(Map<String, dynamic> userData) async {
    try {
      final response = await apiService.updateUserInfo(userData);
      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        return User.fromJson(response.data['content']);
      } else {
        throw Exception('Lỗi khi cập nhật thông tin người dùng: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Lỗi khi gọi API: $e');
    }
  }
}
