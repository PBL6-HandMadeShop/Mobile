import 'package:craftshop2/utils/http/api_service.dart';
import 'package:get/get.dart';

class ProductTypeController extends GetxController {
  final API_Services apiService = API_Services();
  var productTypeData = {}.obs;
  var loading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchProductType(String productId) async {
    loading.value = true;
    errorMessage.value = '';

    final result = await apiService.getProductType(productId);

    if (result['status'] == 'ok') {
      productTypeData.value = result['content'];
    } else {
      errorMessage.value = result['message'];
    }

    loading.value = false;
  }
}
