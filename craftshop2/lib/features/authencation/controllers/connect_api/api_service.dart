import 'dart:convert';
import 'dart:io';
import 'package:craftshop2/features/authencation/models/user_model.dart';
import 'package:craftshop2/utils/local_storage/storage_utility.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import '../../../../utils/constants/api_constants.dart';

class API_Services {
  final Dio _dio = Dio();
  final User user = User();
  final String _baseUrl = APIConstants.BASE_URL;

  API_Services() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<Response> register(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);

      final response = await _dio.post(
        '$_baseUrl/${APIConstants.REGISTER}', // Replace with the actual API URL
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            'ngrok-skip-browser-warning': 'true',
          },
          responseType: ResponseType.json,
        ),
      );
      print('Response data: ${response.data}');
      return response;
    } catch (e) {
      if (e is DioError) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
        return e.response!;
      }
      print('Registration failed: $e');
      return Response(
        requestOptions: RequestOptions(path: '$_baseUrl/${APIConstants.REGISTER}'),
        statusCode: 500,
        statusMessage: 'Registration failed',
      );
    }
  }

  Future<Response> login(Map<String, dynamic> userData) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/${APIConstants.LOGIN}', // URL đăng nhập của bạn
        data: FormData.fromMap(userData),
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      // Kiểm tra phản hồi để xác định đăng nhập có thành công không
      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        // Lấy sessionCode từ phản hồi
        final newSessionCode = response.data['sessionCode'];

        // Lưu sessionCode mới vào local storage
        await CSLocalStorage.saveData('sessionCode', newSessionCode);
        print("Session code saved: $newSessionCode");
        // Khi đăng nhập thành công, bạn cần lưu thông tin người dùng vào localStorage
        final userJson = json.encode(user.toJson());  // user là đối tượng của User model
        await CSLocalStorage.saveData('user_data', userJson);

        return response; // Trả về phản hồi đăng nhập thành công
      } else {
        print("Đăng nhập thất bại: ${response.data['message']}");
        return response; // Trả về phản hồi lỗi
      }
    } catch (e) {
      print('Lỗi khi gọi API đăng nhập: $e');
      throw e; // Ném lỗi để xử lý ngoài hàm này nếu cần
    }
  }
  Future<Response> getUserInfo() async {
    try {
      // Lấy sessionCode đã lưu
      final sessionCode = await CSLocalStorage.getItem('sessionCode');
      if (sessionCode == null) {
        throw 'Không tìm thấy sessionCode, người dùng chưa đăng nhập';
      }

      // Gửi yêu cầu GET để lấy thông tin người dùng
      final response = await _dio.get(
        '$_baseUrl/${APIConstants.GET_INFO_USER}', // Thay thế bằng URL chính xác
        options: Options(
          headers: {
            'Session-Code': sessionCode, // Thêm sessionCode vào header
          },
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        print('Thông tin người dùng: ${response.data['content']}');
        return response; // Trả về thông tin người dùng
      } else {
        throw 'Lỗi: ${response.data['message']}';
      }
    } catch (e) {
      print('Lỗi khi lấy thông tin người dùng: $e');
      throw e;
    }
  }
  Future<Response> updateUserInfo(Map<String, dynamic> userData) async {
    final sessionCode = await CSLocalStorage.getItem('sessionCode');
    if (sessionCode == null) {
      throw 'Không tìm thấy sessionCode, người dùng chưa đăng nhập';
    }

    return await _dio.post(
      '$_baseUrl/api/updateUserInfo',
      data: FormData.fromMap(userData),
      options: Options(
        headers: {
          'Session-Code': sessionCode,
        },
      ),
    );
  }
}