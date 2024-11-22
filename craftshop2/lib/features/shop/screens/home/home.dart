import 'dart:convert';

import 'package:craftshop2/features/shop/screens/home/widgets/home_categories.dart';
import 'package:craftshop2/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:craftshop2/utils/constants/colors.dart';
import 'package:craftshop2/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/widgets/custom_shape/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shape/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cart/product_cart_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';

import '../../../../utils/http/api_service.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../authencation/models/user_model.dart';

import '../all_products/all_products.dart';

import 'widgets/home_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreen createState() => _HomeScreen();
}
class _HomeScreen extends State<HomeScreen>{
  bool isLoading = true;
  final API_Services api_services = API_Services();
  final FlutterSecureStorage storage = FlutterSecureStorage();
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
      // fileData = await api_services.downloadFile("${userInfo?['avatar']?['id']}", token);
      print(userInfo);
      Map<String, dynamic> fetchReviews = await api_services.fetchReviews(
          '670ce6b4f6c452757d354192',token,rating: 0,page: 1, size: 5);
    } catch (e) {
      print('Failed to load user info: $e');
    }  finally {
      setState(() {
        isLoading = false;
      });
    }
    if (userInfo != null) {
      // Access userInfo fields
      String? name = "${userInfo!['name']}"; // Make sure this field is not null
    } else {
      // Handle the case where userInfo is null
    }
  }



  @override
  Widget build(BuildContext context) {
    // Kiểm tra nếu đang tải hoặc thông tin user chưa sẵn sàng
    if (isLoading || userInfo == null) {
      return const Center(
        child: CircularProgressIndicator(), // Hiển thị spinner khi đang tải dữ liệu
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
                  SizedBox(height: CSSize.spaceBtwSections),

                  /// ---SEARCH BAR
                  const CSSearchContainer(text: "Search something ..."),
                  SizedBox(height: CSSize.spaceBtwSections),
                  Padding(
                    padding: const EdgeInsets.only(left: CSSize.defaultSpace),
                    child: Column(
                      children: [
                        const CSSectionHeading(
                          title: 'Popular Categories',
                          textColor: CSColors.white,
                        ),
                        SizedBox(height: CSSize.spaceBtwItems),

                        /// Categories
                        const CSHomeCategories(),
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
                  /// Promo Slider
                  const CSPromoSlider(
                    banners: [
                      CSImage.promoBanner1,
                      CSImage.promoBanner2,
                      CSImage.promoBanner3
                    ],
                  ),

                  /// Popular product
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



