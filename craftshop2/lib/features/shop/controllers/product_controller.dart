// product_controller.dart

import 'package:craftshop2/utils/http/api_service.dart';
import 'package:get/get.dart';


class ProductController extends GetxController {
  var products = <Map<String, dynamic>>[].obs;
  final API_Services apiService = API_Services();

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts({int page = 0, int size = 10}) async {
    final data = await apiService.getProductsPage(page: page, size: size);
    products.value = data as List<Map<String, dynamic>>;
  }
}
