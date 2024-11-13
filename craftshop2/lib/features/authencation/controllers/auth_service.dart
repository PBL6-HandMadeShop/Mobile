
import 'package:craftshop2/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';

import '../models/user_model.dart';


class AuthService {
  final Dio _dio = Dio();
  final String _baseUrl = APIConstants.BASE_URL;
  Future<bool> register(User user) async {
    try {
      FormData formData = FormData.fromMap(
          {
            'usernamw': user.username,
            'name': user.name,
            'email': user.email,
            'phoneNumber': user.phoneNumber,
            'gender' : user.gender,
            'birthDate': user.birthDate,
          });
      final response = await _dio.post(
        '$_baseUrl/${APIConstants.GET_PRODUCT_TYPE}',
          data: formData,
      );

      // Kiểm tra status code hoặc dữ liệu trả về
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Lỗi khi đăng ký: $e');
      return false;
    }
  }
}
