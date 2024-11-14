import 'dart:convert';
import 'dart:io';
import 'package:craftshop2/features/authencation/models/user_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/api_constants.dart';

class API_Services {
  final dio.Dio _dio = dio.Dio();
  final String _baseUrl = APIConstants.BASE_URL;
  final FlutterSecureStorage storage = FlutterSecureStorage();

  API_Services() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    _dio.interceptors.add(dio.InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = await storage.read(key: 'session_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  Future<dio.Response> register(Map<String, dynamic> data) async {
    try {
      dio.FormData formData = dio.FormData.fromMap(data);
      final response = await _dio.post(
        '$_baseUrl/${APIConstants.REGISTER}',
        data: formData,
        options: dio.Options(
          headers: {
            "Content-Type": "multipart/form-data",
            'ngrok-skip-browser-warning': 'true',
          },
          responseType: dio.ResponseType.json,
        ),
      );
      return response;
    } catch (e) {
      if (e is dio.DioError) {
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
        return e.response!;
      }
      return dio.Response(
        requestOptions: dio.RequestOptions(path: '$_baseUrl/${APIConstants.REGISTER}'),
        statusCode: 500,
        statusMessage: 'Registration failed',
      );
    }
  }

  Future<void> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/${APIConstants.LOGIN}',
        data: dio.FormData.fromMap({
          'username': username,
          'password': password,
        }),
        options: dio.Options(
          contentType: dio.Headers.multipartFormDataContentType,
        ),
      );
      print("Full response: $response");

      Map<String, dynamic> responseData = jsonDecode(response.data);
      print("Full response: $responseData");
      if (responseData['status'] == "ok") {
        String token = responseData['sessionCode'];
        print("Token received: $token");

        // Write to secure storage
        await storage.write(key: 'session_token', value: responseData['sessionCode']);

        print("Token saved to secure storage.");

        // Optionally read back the token to confirm
        String? storedToken = await storage.read(key: 'session_token');
        print("Stored token: $storedToken");

      } else {
        print("Login failed: ${responseData['message']}");
      }
    } catch (e) {
      if (e is dio.DioError && e.response != null) {
        print("Status Code: ${e.response?.statusCode}");
        print("Response Data: ${e.response?.data}");
      }
    }
  }

  Future<Map<String, dynamic>?> fetchDataUser(String token) async {
    try {
      if (token == null) {
        print("User is not logged in");
        return null;
      }

      final response = await _dio.get(
        '$_baseUrl/${APIConstants.GET_INFO_USER}',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token', // Add Bearer token for authorization
            'Session-Code': token, // Assuming sessionCode is the same as the token
            'ngrok-skip-browser-warning': 'true', // Include ngrok header
          },
        ),
      );

      Map<String, dynamic> responseData = jsonDecode(response.data);

      if (response.statusCode == 200 && responseData['status'] == 'ok') {
        final userInfo = responseData['content'];
        return userInfo;
        print("User Info: $userInfo");
      } else {
        print("Error fetching data: ${responseData['message']}");
      }
    } catch (e) {
      if (e is dio.DioError) {
        print("Failed to fetch user info: ${e.response?.data ?? e.message}");
      } else {
        print("Failed to fetch user info: $e");
      }
    }
  }
  Future<Map<String, dynamic>?> generatePasswordCode(String email) async {
    try {
      print(email);
      final response = await _dio.post(
        '$_baseUrl/${APIConstants.GENERATE_CODE}',
        data: dio.FormData.fromMap({
          'email': email,
        }),
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        print('Error in response: ${response.statusCode}');
        return {'status': 'error', 'message': 'Unexpected error occurred.'};
      }
    } catch (e) {
      print('Failed to generate password code: $e');
      return {'status': 'error', 'message': e.toString()};
    }
  }

  Future<String?> downloadFileAndSave({String? fileId, required String token}) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/${APIConstants.DOWNLOAD_IMAGE}',
        queryParameters: {'id': fileId},
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Session-Code': token,
            'ngrok-skip-browser-warning': 'true',
          },
          responseType: dio.ResponseType.bytes, // Lấy dữ liệu dưới dạng byte
        ),
      );

      if (response.statusCode == 200) {
        // Lưu file vào bộ nhớ tạm
        final Directory tempDir = await getTemporaryDirectory();
        final String filePath = '${tempDir.path}/$fileId.png';
        final File file = File(filePath);

        await file.writeAsBytes(response.data);
        return filePath;
      }
    } catch (e) {
      print("Failed to download and save file: $e");
    }
    return null;
  }


  Future<void> logout() async {
    await storage.delete(key: 'session_token');
  }

  Future<dio.Response> updateInformation({
    String? name,
    String? phoneNumber,
    String? address,
    File? avatar,
    required String token,
  }) async {
    try {
      final data = {
        if (name != null) 'name': name,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
        if (address != null) 'address': address,
        if (avatar != null) 'avatar': await dio.MultipartFile.fromFile(avatar.path),
      };

      final response = await _dio.post(
        '$_baseUrl/${APIConstants.UPDATE_INFO_USER}',
        data: dio.FormData.fromMap(data),
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Session-Code': token,
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      );

      return response;
    } catch (e) {
      print('Failed to update user info: $e');
      return dio.Response(
        requestOptions: dio.RequestOptions(path: '$_baseUrl/${APIConstants.UPDATE_INFO_USER}'),
        statusCode: 500,
        statusMessage: 'Update failed',
      );
    }
  }
  Future<Map<String, dynamic>> getProductsPage({int page = 0, int size = 10}) async {
    try {
      // URL endpoint lấy trang sản phẩm
      final response = await _dio.get(
        '$_baseUrl/${APIConstants.GET_PROUCT_PAGE}',
        queryParameters: {
          'page': page,
          'size': size,
        },
      );
      Map<String, dynamic> responseData = jsonDecode(response.data);
      // Kiểm tra kết quả
      if (response.statusCode == 200 && responseData['status'] == 'ok') {
        return {
          'status': 'ok',
          'content': responseData['content'], // Danh sách sản phẩm trả về
          'message': responseData['message'],
        };
      } else {
        return {
          'status': 'error',
          'message': responseData['message'] ?? 'Failed to fetch products page',
        };
      }
    } catch (e) {
      print('Error fetching products: $e');
      return {
        'status': 'error',
        'message': 'An error occurred: $e',
      };
    }
  }
}
