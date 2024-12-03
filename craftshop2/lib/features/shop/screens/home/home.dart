import 'package:craftshop2/features/shop/screens/home/widgets/home_categories.dart';
import 'package:craftshop2/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/custom_shape/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shape/containers/search_container.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/http/api_service.dart';
import '../all_products/all_products.dart';
import 'widgets/home_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  bool isLoading = true;
  final API_Services api_services = API_Services();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  Map<String, dynamic>? userInfo;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    setState(() {
      isLoading = true;
    });

    try {
      String? token = await storage.read(key: 'session_token');
      Map<String, dynamic>? fetchedData = await api_services.fetchDataUser(token!);

      setState(() {
        userInfo = fetchedData;
        isLoading = false;
      });

      print(userInfo);
    } catch (e) {
      print('Failed to load user info: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }

    if (userInfo != null) {
      String? name = "${userInfo!['name']}"; // Make sure this field is not null
    }
  }

  Future<void> _searchProducts(String query) async {
    try {
      String? token = await storage.read(key: 'session_token');
      if (token == null) {
        print('No token found!');
        return;
      }

      Map<String, dynamic> result = await api_services.searchProducts(
        token, // Truyền token vào
        query, // Truyền query vào
        page: 0, // Trang 0
        size: 20, // Kích thước 20
      );

      // Xử lý kết quả tìm kiếm
      print("Search Results: $result");

      // Cập nhật giao diện hoặc dữ liệu sau khi nhận được kết quả
    } catch (e) {
      print("Error in searching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Kiểm tra nếu đang tải hoặc thông tin user chưa sẵn sàng
    if (isLoading || userInfo == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Khi dữ liệu đã sẵn sàng, hiển thị nội dung giao diện chính
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            CSPrimaryHeaderContainer(
              child: Column(
                children: [
                  CSHomeAppBar(Subtitle: "${userInfo!['name']}"),
                  const SizedBox(height: CSSize.spaceBtwSections),

                  // ---SEARCH BAR
                  CSSearchContainer(
                    text: "Search something ...",
                    onSearch: (query) => _searchProducts(query), // Gọi hàm tìm kiếm khi người dùng nhập vào
                  ),
                  const SizedBox(height: CSSize.spaceBtwSections),
                  const Padding(
                    padding: EdgeInsets.only(left: CSSize.defaultSpace),
                    child: Column(
                      children: [
                        CSSectionHeading(
                          title: 'Popular Categories',
                          textColor: CSColors.white,
                        ),
                        SizedBox(height: CSSize.spaceBtwItems),

                        // Categories
                        CSHomeCategories(),
                      ],
                    ),
                  )
                ],
              ),
            ),

            // Body
            Padding(
              padding: const EdgeInsets.all(CSSize.defaultSpace),
              child: Column(
                children: [
                  // Promo Slider
                  const CSPromoSlider(
                    banners: [
                      CSImage.promoBanner1,
                      CSImage.promoBanner2,
                      CSImage.promoBanner3
                    ],
                  ),

                  // Popular product
                  const SizedBox(height: CSSize.spaceBtwSections),

                  CSSectionHeading(
                    title: 'Popular Products',
                    onPressed: () => Get.to(() => const AllProducts()),
                  ),

                  const SizedBox(height: CSSize.spaceBtwItems),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
