import 'package:craftshop2/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:craftshop2/features/shop/screens/product_details/widgets/product_atributes.dart';
import 'package:craftshop2/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:craftshop2/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:craftshop2/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'dart:typed_data';

import '../../../../common/widgets/images/cs_rounded_image.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../product_reviews/product_reviews.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> productData;
  final Uint8List? fileData;


  const ProductDetailScreen({
    super.key,
    required this.productData,
    this.fileData,
  });

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: CSBottomAddToCart(productData: productData,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1 - Product Image Slider
            fileData != null
                ? CSProductImageSlider(avatarBlob:fileData, productData:productData , )
                : CSRoundedImage(imageUrl: fileData, applyImageRadius: true),
            // fileData != null
            // ? CSRoundedImage(imageUrl: fileData, applyImageRadius: true)
            // : CSProductImageSlider(avatarBlob:fileData, ),

            /// 2 - Product Details
            Padding(
              padding: EdgeInsets.only(
                right: CSSize.defaultSpace,
                left: CSSize.defaultSpace,
                bottom: CSSize.defaultSpace,
              ),
              child: Column(
                children: [
                  /// - Rating & share
                  CSRatingAndShare(),

                  /// - Price, Title, Stock, Brand
                  CSProductMetaData(
                    productName: productData['name'] ?? 'Product Name',
                    price: productData['currentPrice']?.toString() ?? '0',
                    basePrice: productData['basePrice']?.toString() ?? '0',
                    origin: productData['origin'] ?? 'From the VietNam Handcrafted',
                    status: productData['status'] ?? 'Loading',
                  ),

                  /// - Attributes
                  CSProductAtributes(quantityRemain:productData["quantityRemain"] ?? "Loading",),

                  /// - Description
                  const SizedBox(height: CSSize.spaceBtwSections),
                  const CSSectionHeading(title: 'Description', showActionButton: false),
                  const SizedBox(height: CSSize.spaceBtwItems),
                  ReadMoreText(
                    productData['description'] ?? 'No description available',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show More',
                    trimExpandedText: 'Less',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  /// - Reviews
                  const Divider(),
                  const SizedBox(height: CSSize.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CSSectionHeading(title: 'Review(199)', showActionButton: false),
                      IconButton(
                        onPressed: () => Get.to(() => const ProductReviewScreen()),
                        icon: const Icon(Iconsax.arrow_right_3, size: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: CSSize.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
