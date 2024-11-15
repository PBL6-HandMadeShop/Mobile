import 'package:craftshop2/utils/http/api_service.dart';
import 'package:get/get.dart';


class ProductTypePageController extends GetxController {
  final API_Services apiService = API_Services();
  var productTypes = <Map<String, dynamic>>[].obs;
  var loading = false.obs;

  @override
  void onInit() {
    fetchAllProductTypes();
    super.onInit();
  }

  Future<void> fetchAllProductTypes() async {
    loading.value = true;
    int page = 0;
    int size = 10;
    List<Map<String, dynamic>> allProductTypes = [];

    try {
      while (true) {
        var productTypesPage = await apiService.getProductTypesPage(page: page, size: size);
        if (productTypesPage.isEmpty) break;

        allProductTypes.addAll(productTypesPage);
        page++;
      }
      productTypes.value = allProductTypes;
    } catch (e) {
      print("Error fetching product types: $e");
    } finally {
      loading.value = false;
    }
  }
}
