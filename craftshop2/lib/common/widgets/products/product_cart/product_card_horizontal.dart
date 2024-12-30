import 'package:craftshop2/common/styles/shadows.dart';
import 'package:craftshop2/common/widgets/custom_shape/containers/rounded_container.dart';
import 'package:craftshop2/common/widgets/icons/cs_circular_icon.dart';
import 'package:craftshop2/common/widgets/images/cs_rounded_image.dart';
import 'package:craftshop2/common/widgets/texts/cs_brand_title_text_with_vertified_icon.dart';
import 'package:craftshop2/utils/constants/colors.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/http/api_service.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title.dart';
import 'dart:typed_data';
class CSProductCardHorizontal extends StatefulWidget {
  const CSProductCardHorizontal({super.key, required this.productData});
  final Map<String, dynamic> productData;

  @override
  _CSProductCardHorizontal createState() => _CSProductCardHorizontal();
}
class _CSProductCardHorizontal extends State<CSProductCardHorizontal> {
  final API_Services api_services = API_Services();
  Map<String, dynamic>? productInfo;
  Map<String, dynamic>? productReview;
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  Uint8List? fileData;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadProductDataAndImage();
  }

  Future<void> _loadProductDataAndImage() async {
    setState(() {
      isLoading = true;
    });

    try {
      String? token = await storage.read(key: 'session_token');

      // Tải dữ liệu sản phẩm, hình ảnh và reviews song song
      final productInfoFuture = Future.value(
          widget.productData); // Sử dụng dữ liệu có sẵn
      final imageFuture = _loadProductImage();

      final reviewsFuture = api_services.fetchReviews(
        widget.productData['id'],
        token!,
        rating: 0,
      );

      // Sử dụng Future.wait để chạy các tác vụ song song
      final results = await Future.wait(
          [productInfoFuture, imageFuture, reviewsFuture]);

      setState(() {
        productInfo = results[0] as Map<String, dynamic>?; // Dữ liệu sản phẩm
        fileData = results[1] as Uint8List?; // Dữ liệu ảnh
        productReview = results[2] as Map<String, dynamic>?; // Dữ liệu review
      });
      // print("product ID ${widget.productData['id']}");
      // print("product cart vertical ${productReview?['content']}");
      // Kiểm tra và in ra dữ liệu voucher nếu có
      if (widget.productData['vouchers'] != null &&
          widget.productData['vouchers'].isNotEmpty) {
        // print('discount ${widget.productData['vouchers']}');
      } else {
        print('No vouchers available');
      }
    } catch (e) {
      print('Failed to load product data, image or reviews: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<Uint8List?> _loadProductImage() async {
    try {
      final String imageId = widget.productData['avatar']?['id'] ?? '';
      print("String image $imageId");
      if (imageId.isNotEmpty) {
        return await api_services.downloadProductImage(imageId);
      }
    } catch (e) {
      print("Error downloading product image: $e");
    }
    return null; // Nếu không có ảnh, trả về null
  }
  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(
        productData: widget.productData ?? {},
        fileData: fileData,
        productReview: productReview ?? {},)
      ),
      child: Container(
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [CSShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(CSSize.productImageRadius),
          color: dark ? CSColors.darkerGrey : CSColors.softGrey,
        ), // BoxDecoration
        child: Row(
          children: [

            /// Thumbnail
            CSRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(CSSize.sm),
              backgroundColor: dark ? CSColors.dark : CSColors.light,
              child: Stack(
                children: [

                  /// -- Thumbnail Image
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: CSRoundedImage(
                        imageUrl: fileData, applyImageRadius: true),
                  ), // SizedBox

                  /// -- Sale Tag
                  Positioned(
                    top: 12,
                    child: CSRoundedContainer(
                      radius: CSSize.sm,
                      backgroundColor: CSColors.secondaryColor.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: CSSize.sm, vertical: CSSize.xs),
                      child: Text( widget.productData['vouchers'] != null && widget.productData['vouchers'].isNotEmpty
                          ? '${widget.productData['vouchers'][0]['value'] ?? 0}%'
                          : '0%', style: Theme
                          .of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: CSColors.black)),
                    ), // TRoundedContainer
                  ), // Positioned

                  /// -- Favourite Icon Button
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: CSCircularlIcon(
                        icon: Iconsax.heart5, color: Colors.red),
                  ),


                ], // Stack children
              ), // Stack
            ),

            /// Detail
            SizedBox(
              width: 172,
              child: Padding(
                padding: const EdgeInsets.only(top: CSSize.sm, left: CSSize.sm),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CSProductTitleText(title: widget.productData['name'] ?? 'Product Name',
                            smallSize: true),
                        const SizedBox(height: CSSize.spaceBtwItems / 2),
                        CsBrandTitleTextWithVertifiedIcon(title: widget.productData['origin'] ?? 'Product Name',),
                      ], // Column children
                    ),

                    const Spacer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        /// Pricing
                         Flexible(child: CSProductPriceText(price: widget.productData['currentPrice']?.toString() ?? '0',)),

                        /// Add to cart
                        Container(
                          decoration: const BoxDecoration(
                            color: CSColors.dark,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(CSSize.cardRadiusMd),
                              bottomRight: Radius.circular(
                                  CSSize.productImageRadius),
                            ), // BorderRadius.only
                          ), // BoxDecoration
                          child: const SizedBox(
                            width: CSSize.iconLg * 1.2,
                            height: CSSize.iconLg * 1.2,
                            child: Center(child: Icon(
                                Iconsax.add, color: CSColors.white)),
                          ), // SizedBox
                        ), // Container
                      ], // Row children
                    ), // Row


                  ], // Column children
                ),
              ),
            ),

          ], // Row children
        ),
      ),
    );
  }

}