import 'package:craftshop2/features/shop/screens/store/widget/category_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/brand/card_brand.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/appbar/tab_bar.dart';
import '../../../../common/widgets/custom_shape/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/http/api_service.dart';
import '../brand/all_brands.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  _Store createState() => _Store();
}

class _Store extends State<Store> {
  final API_Services api_services = API_Services();
  Map<String, dynamic> productPage = {}; // Map to hold product page
  List<Map<String, dynamic>> productPages = []; // List to hold product pages

  bool isLoading = true;
  final FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadProductTypes();
  }

  // Hàm load các loại sản phẩm từ API
  Future<void> _loadProductTypes() async {
    try {
      String? token = await storage.read(key: 'session_token');
      Map<String, dynamic> fetchedData1 = await api_services.getProductTypesPage(size: 100, token: token!);

      if (!mounted) return; // Kiểm tra nếu widget còn tồn tại

      setState(() {
        // Load all the 'content' from fetchedData1 into productPages list
        productPages = List<Map<String, dynamic>>.from(fetchedData1['content'] ?? []);
      });
    } catch (e) {
      if (!mounted) return; // Kiểm tra nếu widget còn tồn tại
      print('Error fetching products: $e');
    }
  }

  // Hàm tìm kiếm sản phẩm khi người dùng nhập từ khóa vào
  Future<void> _searchProducts(String query) async {
    try {
      String? token = await storage.read(key: 'session_token'); // Đọc token từ FlutterSecureStorage
      if (token == null) {
        print('No token found!');
        return; // Nếu không có token, không thực hiện tìm kiếm
      }

      // Gọi API tìm kiếm sản phẩm với token, query và các tham số khác
      Map<String, dynamic> result = await api_services.searchProducts(
        token,  // Truyền token vào
        query,  // Truyền query vào
        page: 0,  // Trang 0
        size: 20,  // Kích thước 20
      );

      // Xử lý kết quả tìm kiếm ở đây
      print("Search Results: $result");

      // Cập nhật giao diện hoặc dữ liệu sau khi nhận được kết quả
      if (result['status'] == 'success') {
        setState(() {
          productPage = result['data']; // Giả sử dữ liệu sản phẩm nằm trong 'data'
        });
      } else {
        print('Failed to fetch products');
      }

    } catch (e) {
      print("Error in searching products: $e");
    }
  }




  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: productPages.length, // Dynamically set the number of tabs based on productPages length
      child: Scaffold(
        appBar: CSAppBar(
          title: Text(
            "Store",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [CSCartCounterIcon(onPressed: () {})],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: CSHelperFunctions.isDarkMode(context)
                    ? CSColors.dark
                    : CSColors.white,
                expandedHeight: 200,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(CSSize.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: CSSize.spaceBtwSections),
                      CSSearchContainer(
                        text: "Search in store",
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                        onSearch: _searchProducts, // Sử dụng hàm _searchProducts khi người dùng nhập tìm kiếm
                      ),
                    ],
                  ),
                ),

                bottom: CSTabBar(
                  tabs: productPages.map<Widget>((productPage) {
                    return Tab(child: Text('${productPage['name']}' ?? 'Unnamed Tab'));
                  }).toList(), // Dynamically create tabs from productPages
                ),
              ),
            ];
          },
          body: productPages.isEmpty
              ? const Center(child: CircularProgressIndicator()) // Show loading indicator while data is being fetched
              : TabBarView(
            children: productPages.map<Widget>((productPage) {
              return CsCategoryTab(productPage: productPage); // Pass each productPage to CsCategoryTab
            }).toList(), // Dynamically create TabBarView content

          ),
        ),
      ),
    );
  }
}