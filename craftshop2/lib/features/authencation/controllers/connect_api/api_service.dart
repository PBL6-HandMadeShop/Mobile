import 'dart:convert';
import 'dart:io';
import 'package:craftshop2/features/authencation/models/user_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/io.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../utils/constants/api_constants.dart';

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

  Future<Map<String, dynamic>?> fetchData(String token) async {
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

  Future<void> logout() async {
    await storage.delete(key: 'session_token');
  }
}
