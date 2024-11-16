import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/http/api_service.dart';
import '../../../styles/shadows.dart';
import '../../custom_shape/containers/rounded_container.dart';
import '../../icons/cs_circular_icon.dart';
import '../../images/cs_rounded_image.dart';
import '../../texts/cs_brand_title_text_with_vertified_icon.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title.dart';

class CSProductCardVertical extends StatefulWidget {
  final Map<String, dynamic> productData;

  const CSProductCardVertical({super.key, required this.productData});

  @override
  _CSProductCardVertical createState() => _CSProductCardVertical();
}

class _CSProductCardVertical extends State<CSProductCardVertical> {
  final API_Services api_services = API_Services();
  Map<String, dynamic>? productInfo;
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
      // Tải song song dữ liệu sản phẩm và ảnh
      final productInfoFuture = Future.value(widget.productData); // Sử dụng dữ liệu có sẵn
      final imageFuture = _loadProductImage();

      final results = await Future.wait([productInfoFuture, imageFuture]);

      setState(() {
        productInfo = results[0] as Map<String, dynamic>?;
        fileData = results[1] as Uint8List?;
      });
    } catch (e) {
      print('Failed to load product data or image: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<Uint8List?> _loadProductImage() async {
    try {
      final String imageId = widget.productData['avatarBlob']?['id'] ?? '';
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
      onTap: () => Get.to(() => const ProductDetailScreen()),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [CSShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(CSSize.productImageRadius),
          color: dark ? CSColors.darkgrey : CSColors.white,
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            CSRoundedContainer(
              height: 178,
              padding: const EdgeInsets.all(CSSize.sm),
              backgroundColor: dark ? CSColors.dark : CSColors.light,
              child: Stack(
                children: [
                  // Hiển thị ảnh đã tải hoặc ảnh mặc định
                  CSRoundedImage(
                    imageUrl: fileData ?? CSImage.product1,
                    applyImageRadius: true,
                  ),
                  Positioned(
                    top: 12,
                    child: CSRoundedContainer(
                      padding: const EdgeInsets.symmetric(horizontal: CSSize.sm, vertical: CSSize.xs),
                      radius: CSSize.sm,
                      backgroundColor: CSColors.secondaryColor.withOpacity(0.8),
                      child: Text(
                        '20% OFF',
                        style: Theme.of(context).textTheme.labelLarge!.apply(color: CSColors.black),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CSCircularlIcon(
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: CSSize.spaceBtwItems / 2),
            Padding(
              padding: EdgeInsets.only(left: CSSize.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CSProductTitleText(
                    title: productInfo?['name'] ?? 'Product Name',
                    smallSize: true,
                  ),
                  SizedBox(height: CSSize.spaceBtwItems / 2),
                  CsBrandTitleTextWithVertifiedIcon(
                    title: productInfo?['description'] ?? 'Product Description',
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: CSSize.sm),
                  child: CSProductPriceText(
                    price: productInfo?['currentPrice']?.toString() ?? '0',
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: CSColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(CSSize.cardRadiusMd),
                      bottomRight: Radius.circular(CSSize.productImageRadius),
                    ),
                  ),
                  child: const SizedBox(
                    width: CSSize.iconLg * 1.2,
                    height: CSSize.iconLg * 1.2,
                    child: Center(
                      child: Icon(
                        Iconsax.add,
                        color: CSColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
