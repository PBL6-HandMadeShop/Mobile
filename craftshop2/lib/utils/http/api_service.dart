import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';

import 'package:dio/io.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import '../constants/api_constants.dart';

class API_Services {
  final dio.Dio _dio = dio.Dio();
  final String _baseUrl = APIConstants.BASE_URL;
  final FlutterSecureStorage storage = FlutterSecureStorage();

  API_Services() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
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
        requestOptions: dio.RequestOptions(
            path: '$_baseUrl/${APIConstants.REGISTER}'),
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
        await storage.write(
            key: 'session_token', value: responseData['sessionCode']);

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
            'Authorization': 'Bearer $token',
            // Add Bearer token for authorization
            'Session-Code': token,
            // Assuming sessionCode is the same as the token
            'ngrok-skip-browser-warning': 'true',
            // Include ngrok header
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

  Future<Uint8List?> downloadFile(String id, String token) async {
    try {
      Response response = await _dio.get(
        '$_baseUrl/${APIConstants.DOWNLOAD_IMAGE}',
        queryParameters: {
          'id': id, // Hoặc bạn có thể sử dụng 'name': 'filename'
        },

        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            'Authorization': 'Bearer $token',
            // Add Bearer token for authorization
            'Session-Code': token,
            // Assuming sessionCode is the same as the token
            'ngrok-skip-browser-warning': 'true',
            // Include ngrok header
          }, // Để nhận dữ liệu dạng binary
        ),
      );

      // Kiểm tra nếu tải thành công và trả về dữ liệu binary (file)
      if (response.statusCode == 200) {
        return response.data; // Trả về dữ liệu binary của file
      } else {
        print('Failed to download file: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error downloading file: $e');
      return null;
    }
  }

  Future<Uint8List?> downloadProductImage(String id) async {
    try {
      Response response = await _dio.get(
        '$_baseUrl/${APIConstants.DOWNLOAD_IMAGE}',
        queryParameters: {
          'id': id, // Hoặc bạn có thể sử dụng 'name': 'filename'
        },

        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            'ngrok-skip-browser-warning': 'true', // Include ngrok header
          }, // Để nhận dữ liệu dạng binary
        ),
      );

      // Kiểm tra nếu tải thành công và trả về dữ liệu binary (file)
      if (response.statusCode == 200) {
        return response.data; // Trả về dữ liệu binary của file
      } else {
        print('Failed to download file: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error downloading file: $e');
      return null;
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'session_token');
  }

  Future<dio.Response> updateInformation(
      {String? name, String? phoneNumber, String? address, File? avatar, required String token,}) async {
    try {
      final data = {
        if (name != null) 'name': name,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
        if (address != null) 'address': address,
        if (avatar != null) 'avatar': await dio.MultipartFile.fromFile(
            avatar.path),
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
        requestOptions: dio.RequestOptions(
            path: '$_baseUrl/${APIConstants.UPDATE_INFO_USER}'),
        statusCode: 500,
        statusMessage: 'Update failed',
      );
    }
  }

  Future<Map<String, dynamic>> fetchProducts(
      {int page = 0, int size = 10}) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/${APIConstants.GET_PRODUCTS_PAGE}',
        queryParameters: {
          'page': page,
          'size': size,
        },
      );
      Map<String, dynamic> responseData = jsonDecode(response.data);
      if (response.statusCode == 200) {
        print("Response product data: $responseData");
        return responseData; // Dữ liệu trả về dạng Map<String, dynamic>
      } else {
        throw Exception("Failed to fetch products: ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("Error occurred while fetching products: $e");
    }
  }

  Future<Map<String, dynamic>> getProductType(String productId) async {
    try {
      final response = await _dio.get(
          '$_baseUrl/${APIConstants.GET_PRODUCT_TYPE}',
          queryParameters: {'id': productId});
      Map<String, dynamic> responseData = jsonDecode(response.data);
      if (response.statusCode == 200 && responseData['status'] == 'ok') {
        return {
          'status': 'ok',
          'message': responseData['message'],
          'content': responseData['content'],
        };
      } else {
        return {
          'status': 'error',
          'message': responseData['message'] ?? 'Unknown error occurred',
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Failed to fetch data: $e',
      };
    }
  }
  Future<Map<String, dynamic>> fetchUserInfo() async {
    try {
      // Lấy token từ secure storage
      String? token = await storage.read(key: 'session_token');

      if (token == null) {
        throw Exception('User is not logged in or session token is missing.');
      }

      // Gửi yêu cầu tới API getUserInfo
      final response = await _dio.get(
        '$_baseUrl/${APIConstants.GET_INFO_USER}',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token', // Thêm token vào header Authorization
            'ngrok-skip-browser-warning': 'true', // Nếu đang dùng ngrok
          },
        ),
      );

      // Phân tích dữ liệu trả về
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;

        // Kiểm tra trạng thái trả về
        if (responseData['status'] == 'ok') {
          return {
            'status': 'ok',
            'content': responseData['content'], // Trả về thông tin user
          };
        } else {
          return {
            'status': 'error',
            'message': responseData['message'] ?? 'Failed to fetch user info',
          };
        }
      } else {
        throw Exception('Failed to fetch user info. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user info: $e');
      return {
        'status': 'error',
        'message': 'An error occurred while fetching user info: $e',
      };
    }
  }

  Future<Map<String, dynamic>> getProductTypesPage(
      {int size = 100, required String token}) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/${APIConstants.GET_PRODUCT_TYPE_PAGE}',
        queryParameters: {
          'size': size,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Session-Code': token,
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      );
      Map<String, dynamic> responseData = jsonDecode(response.data);
      if (response.statusCode == 200) {
        print("Response getProductTypesPage data: $responseData");
        return responseData; // Dữ liệu trả về dạng Map<String, dynamic>
      } else {
        throw Exception("Failed to fetch products: ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("Error occurred while fetching products: $e");
    }
  }

  Future<Map<String, dynamic>> getCartItems(String token) async {
    try {
      // Gửi yêu cầu POST đến API getCartItem
      final response = await _dio.post(
        '$_baseUrl/${APIConstants.GET_CART_ITEMS}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            // Add Bearer token for authorization
            'Session-Code': token,
            // Assuming sessionCode is the same as the token
            'ngrok-skip-browser-warning': 'true',
            // Include ngrok header
          },
        ),
      );

      // Kiểm tra nếu API trả về status ok
      if (response.statusCode == 200) {
        return response.data; // Trả về dữ liệu API
      } else {
        throw Exception('Failed to load cart items');
      }
    } catch (e) {
      // In lỗi nếu có sự cố trong quá trình gọi API
      print('Error: $e');
      return {'status': 'error', 'message': 'Something went wrong'};
    }
  }

  Future<dio.Response> addToCart(String productId, int quantity,
      String token) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/${APIConstants.ADD_CART_ITEM}', // API endpoint
        data: dio.FormData.fromMap({
          'productId': productId,
          'quantity': quantity,
        }),
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
            // Add Bearer token for authorization
            'Session-Code': token,
            // Assuming sessionCode is the same as the token
            'ngrok-skip-browser-warning': 'true',
            // Include ngrok header
          },
        ),
      );

      if (response.statusCode == 200) {
        return response; // Return the API response
      } else {
        throw Exception('Failed to add item to cart');
      }
    } catch (e) {
      print('Error: $e');
      return dio.Response(
        requestOptions: dio.RequestOptions(
            path: '$_baseUrl/${APIConstants.ADD_CART_ITEM}'),
        statusCode: 500,
        statusMessage: 'Something went wrong',
        data: {'status': 'error', 'message': 'Something went wrong'},
      );
    }
  }

  Future<Map<String, dynamic>> removeFromCart(String productId,
      String token) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/${APIConstants.REMOVE_CART_ITEM}', // Địa chỉ API
        data: FormData.fromMap({
          'productId': productId, // Chỉ cần truyền ID của sản phẩm cần xóa
        }),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            // Add Bearer token for authorization
            'Session-Code': token,
            // Assuming sessionCode is the same as the token
            'ngrok-skip-browser-warning': 'true',
            // Include ngrok header
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data; // Trả về dữ liệu API
      } else {
        throw Exception('Failed to remove item from cart');
      }
    } catch (e) {
      print('Error: $e');
      return {'status': 'error', 'message': 'Something went wrong'};
    }
  }

  Future<Map<String, dynamic>> fetchReviews(
      String productId, String token,
      {int rating = 0, int page = 0, int size = 10}) async {
    try {
      // In URL để kiểm tra nếu cần
      print('Fetching reviews for productId: $productId');

      final response = await _dio.get(
        '$_baseUrl/${APIConstants.GET_REVIEWS_BY_PRODUCT}',
        queryParameters: {
          'productId': productId,
          'rating': rating,
          'page': page,
          'size': size,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Session-Code': token,
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        print('Reviews fetched successfully: ${response.data}');
        return response.data;
      } else {
        throw Exception('Failed to fetch reviews: ${response.statusMessage}');
      }
    } catch (e) {
      if (e is DioError) {
        print('DioError: ${e.response?.data ?? e.message}');
      } else {
        print('Unexpected Error: $e');
      }
      return {'status': 'error', 'message': 'Failed to fetch reviews'};
    }
  }

}

