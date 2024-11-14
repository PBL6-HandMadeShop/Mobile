import 'dart:convert';
import 'dart:io';
import 'package:craftshop2/utils/local_storage/storage_utility.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

class CSHttpClient {
  static const String _baseUrl = APIConstants.BASE_URL;


  HttpClient _createHttpClient() {
    final client = HttpClient();
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  }



  Future<http.Response> customPostRequest(Uri uri, Map<String, String> headers, String body) async {
    final client = http.Client();
    final request = await client.post(uri, headers: headers, body: body);
    return request;
  }
  // Helper method to register user using MultipartRequest
  static Future<Map<String, dynamic>> register(Map<String, String> data) async {
    var uri = Uri.parse('$_baseUrl/${APIConstants.REGISTER}');

    try {
      var request = http.MultipartRequest('POST', uri);

      // Prepare request fields
      request.fields['name'] = data['name']!;
      request.fields['email'] = data['email']!;
      request.fields['phoneNumber'] = data['phoneNumber']!;
      request.fields['username'] = data['username']!;
      request.fields['gender'] = data['gender']!;
      request.fields['birthDate'] = data['birthDate']!; // Keep as YYYY-MM-DD
      request.fields.addAll(data); // Use addAll to add fields directly from the map

      print("Request fields: ${request.fields}");

      final response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        return json.decode(responseData.body) as Map<String, dynamic>; // Ensure it's a Map
      } else {
        String errorDetails = await response.stream.bytesToString();
        print('Failed to register: ${response.statusCode}, Details: $errorDetails');
        throw Exception('Failed to register: ${response.statusCode}, Details: $errorDetails');
      }
    } catch (e) {
      print('Network error: $e');
      throw Exception('Network error: $e');
    }
  }


  // Helper method to login user
  static Future<Map<String, dynamic>> login(Map<String, String> data) async {
    var uri = Uri.parse('$_baseUrl/${APIConstants.LOGIN}');

    try {
      // Create a multipart request
      var request = http.MultipartRequest('POST', uri);

      // Add the fields to the request
      request.fields['username'] = data['username']!;
      request.fields['password'] = data['password']!;

      // Send the request
      final response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        final Map<String, dynamic> responseBody = json.decode(responseData.body);
        final accessToken = responseBody['sessionCode'];
        await CSLocalStorage.saveData('access_token', accessToken);
        print('Token saved: $accessToken');
        return responseBody;
      } else {
        print('Failed to login: ${response.statusCode}, Details: ${await response.stream.bytesToString()}');
        throw Exception('Failed to login: ${response.statusCode}, Details: ${await response.stream.bytesToString()}');
      }
    } catch (e) {
      print('Network error: $e');
      throw Exception('Network error: $e');
    }
  }
  static Future<Map<String, dynamic>> logout() async {
    var uri = Uri.parse('$_baseUrl/${APIConstants.LOGOUT}');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      return {'status': 'error', 'message': 'Logout failed due to server error'};
    }
  }
  // Helper method to get user info
  static Future<Map<String, dynamic>> getUserInfo() async {
    var uri = Uri.parse('$_baseUrl/${APIConstants.GET_INFO_USER}');
    final token = await CSLocalStorage.readData('access_token'); // Make sure to await the async method
    print('Token retrieved: $token');

    try {
      if (token == null) {
        throw Exception("User is not logged in");
      }

      // Log the URI being requested
      print('Fetching user info from: $uri');

      final response = await http.get(uri, headers: {
        'Session-code': "",
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'ngrok-skip-browser-warning': 'true',
      });

      // Log the response status and body
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      // Check the response
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'ok') {
          final userInfo = responseData['content'];
          // Check if accountStatus is ACTIVE
          if (userInfo['accountStatus'] == 'ACTIVE') {
            print("User info fetched: $userInfo");
            return userInfo;
          } else {
            throw Exception('Account is not active');
          }
        } else {
          throw Exception('Failed to get user info: ${responseData['message']}');
        }
      } else {
        throw Exception('Failed to get user info: ${response.statusCode}, Details: ${response.body}');
      }
    } catch (e) {
      print('Failed to get user info: $e');
      throw Exception('Failed to get user info: $e');
    }
  }

  // Common headers for JSON requests
   static Map<String, String> _headers() {
    return {
      'Content-Type': 'application/json',
      'ngrok-skip-browser-warning': 'true',
    };
  }

  // Helper method for GET request
  static Future<Map<String, dynamic>> get(String endPoint) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$endPoint'), headers: _headers());
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Helper method for POST request
  static Future<Map<String, dynamic>> post(String endPoint, dynamic data) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/$endPoint'),
        headers: _headers(),
        body: json.encode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Helper method for PUT request
  static Future<Map<String, dynamic>> put(String endPoint, dynamic data) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$endPoint'),
        headers: _headers(),
        body: json.encode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Helper method for DELETE request
  static Future<Map<String, dynamic>> delete(String endPoint) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/$endPoint'), headers: _headers());
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> getProductType(String id) async {
    try {
      final response = await Dio().get(
        get(APIConstants.GET_PRODUCT_TYPE) as String, // Thay bằng URL thực tế
        queryParameters: {'id': id},
      );

      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        return {
          'status': 'ok',
          'content': response.data['content'],
          'message': response.data['message'],
        };
      } else {
        return {
          'status': 'error',
          'message': response.data['message'] ?? 'Error fetching product type',
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'An error occurred: $e',
      };
    }
  }
  // Handle response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}, Response: ${response.body}');
    }
  }
}