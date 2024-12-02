// controllers/registration/register_controller.dart
import '../../../../utils/http/api_service.dart';

class RegisterController {
  final API_Services _registrationApi = API_Services();

  Future<void> registerUser(Map<String, dynamic> userData) async {
    try {
      final response = await _registrationApi.register(userData);

      if (response.statusCode == 200) {
        print("Đăng ký thành công!");
      } else {
        print("Đăng ký thất bại với mã lỗi: ${response.statusCode}");
      }
    } catch (e) {
      print('Đăng ký thất bại: $e');
    }
  }
}
