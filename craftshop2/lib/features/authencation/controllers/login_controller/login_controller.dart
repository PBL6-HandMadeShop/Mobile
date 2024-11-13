// import '../connect_api/api_service.dart';
//
// class LoginController {
//   final API_Services _loginApi = API_Services();
//
//   Future<void> loginUser(Map<String, dynamic> userData) async {
//     try {
//       final response = await _loginApi.login(userData);
//
//       if (response.statusCode == 200) {
//         print("Đăng nhập thành công!");
//       } else {
//         print("Đăng nhập thất bại với mã lỗi: ${response.statusCode}");
//       }
//     } catch (e) {
//       print('Đăng nhập thất bại: $e');
//     }
//   }
// }