import 'package:dio/dio.dart';

import '../models/model_category.dart';

class ProductService {
  final Dio _dio = Dio();

  Future<List<Product>> getProductsPage(int page, int size) async {
    try {
      final response = await _dio.get(
        'https://yourapi.com/api/getProductsPage',
        queryParameters: {
          'page': page,
          'size': size,
        },
      );

      if (response.data['status'] == 'ok') {
        List<Product> products = (response.data['content'] as List)
            .map((e) => Product.fromJson(e))
            .toList();
        return products;
      } else {
        throw Exception('Error: ${response.data['message']}');
      }
    } catch (e) {
      print('Đăng ký thất bại: $e');
      throw Exception('Không thể lấy dữ liệu sản phẩm');
    }
  }
}
