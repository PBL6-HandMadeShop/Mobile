import 'package:craftshop2/features/shop/screens/home/widgets/home_categories.dart';
import 'package:craftshop2/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/custom_shape/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shape/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cart/product_cart_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/http/api_service.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../authencation/models/user_model.dart';
import '../all_products/all_products.dart';
import 'widgets/home_appbar.dart';
import 'dart:typed_data';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  bool isUserLoading = true; // Trạng thái tải thông tin người dùng
  bool isProductLoading = true; // Trạng thái tải dữ liệu sản phẩm
  final API_Services api_services = API_Services();
  final FlutterSecureStorage storage = FlutterSecureStorage();
  Map<String, dynamic>? userInfo;
  List<Uint8List?> productImages = [];
  List<dynamic>? productPagePopular;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadProductPage().then((_) => _loadProductImages());
  }
  Future<void> _loadProductImages() async {
    try {
      if (productPagePopular != null) {
        final List<dynamic> products = productPagePopular!;
        final List<Future<Uint8List?>> futures = products.map((product) async {
          final String? imageId = product['avatar']?['id'];
          if (imageId != null && imageId.isNotEmpty) {
            return await api_services.downloadProductImage(imageId);
          }
          return null;
        }).toList();

        final images = await Future.wait(futures); // Tải tất cả hình ảnh
        setState(() {
          productImages = images.where((image) => image != null).toList();
        });
      }
    } catch (e) {
      print("Error loading product images: $e");
    }
  }
  Future<void> _loadProductPage() async {
    setState(() {
      isProductLoading = true;
    });
    try {
      String? token = await storage.read(key: 'session_token');
      Map<String, dynamic> fetchedData1 = await api_services.getProductTypesPage(size: 100, token: token!);

      // Gộp tất cả sản phẩm từ content
      List<dynamic> allProducts = [];
      if (fetchedData1["content"] != null && fetchedData1["content"] is List) {
        for (var item in fetchedData1["content"]) {
          if (item["producs"] != null && item["producs"] is List) {
            allProducts.addAll(item["producs"]);
          }
        }
      }

      setState(() {
        productPagePopular = allProducts;
      });

      print("All products: $productPagePopular");
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      setState(() {
        isProductLoading = false;
      });
    }
  }



  Future<void> _loadUserInfo() async {
    setState(() {
      isUserLoading = true;
    });
    try {
      String? token = await storage.read(key: 'session_token');
      Map<String, dynamic>? fetchedData = await api_services.fetchDataUser(token!);
      setState(() {
        userInfo = fetchedData;
      });
      print(userInfo);
    } catch (e) {
      print('Failed to load user info: $e');
    } finally {
      setState(() {
        isUserLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Kiểm tra nếu đang tải thông tin user
    if (isUserLoading || userInfo == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

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
                  CSSearchContainer(
                    text: "Search something ...",
                    onSearch: (String value) {  },
                  ),
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
                        const CSHomeCategories(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Body
            Padding(
              padding: const EdgeInsets.all(CSSize.defaultSpace),
              child: Column(
                children: [
                  // Promo Slider
                  productImages.isEmpty
                      ? const CircularProgressIndicator() // Hiển thị loading nếu chưa tải xong
                      : CSPromoSlider(
                    banners: productImages, // Sử dụng hình ảnh tải được
                  ),
                  const SizedBox(height: CSSize.spaceBtwSections),

                  // Popular Products
                  CSSectionHeading(
                    title: 'Popular Products',
                    onPressed: () => Get.to(() => const AllProducts()),
                  ),
                  const SizedBox(height: CSSize.spaceBtwItems),

                  // Kiểm tra nếu đang tải sản phẩm
                  isProductLoading
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : CSGridLayout(
                    itemCount: 8,
                    itemBuilder: (_, index) {
                      final productData = productPagePopular?[index];
                      return productData != null
                          ? CSProductCardVertical(productData: productData)
                          : const SizedBox.shrink();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}