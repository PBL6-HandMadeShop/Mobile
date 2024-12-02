import 'package:craftshop2/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:craftshop2/features/shop/screens/product_details/widgets/product_atributes.dart';
import 'package:craftshop2/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:craftshop2/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:craftshop2/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'dart:typed_data';

import '../../../../common/widgets/images/cs_rounded_image.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../product_reviews/product_reviews.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> productData;
  final Map<String, dynamic> productReview;
  final Uint8List? fileData;

  const ProductDetailScreen({
    super.key,
    required this.productData,
    this.fileData, required this.productReview,
  });
  String _getAmountReview({
    required Map<String, dynamic> productReview,
  }) {
    final count = productReview['content']?.length ?? 0;
    return count == 0 ? 'No review' : '$count review';
  }
  String _getAmountRating({
    required Map<String, dynamic> productReview,
  }) {
    final count = productReview['content']?.length ?? 0;
    return count == 0 ? 'No rating' : '$count rating';
  }
  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    // print(fileData);
    // print("review: ${productReview["content"]}");
    // print("review: $productReview");
    return Scaffold(
      bottomNavigationBar: CSBottomAddToCart(productData: productData,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1 - Product Image Slider
            fileData != null
                ? CSProductImageSlider(avatarBlob:fileData, productData:productData , )
                : CSRoundedImage(imageUrl:  fileData ?? CSImage.product1, applyImageRadius: true),
            // fileData != null
            // ? CSRoundedImage(imageUrl: fileData, applyImageRadius: true)
            // : CSProductImageSlider(avatarBlob:fileData, productData: productData, ),

            /// 2 - Product Details
            Padding(
              padding: const EdgeInsets.only(
                right: CSSize.defaultSpace,
                left: CSSize.defaultSpace,
                bottom: CSSize.defaultSpace,
              ),
              child: Column(
                children: [
                  /// - Rating & share
                  CSRatingAndShare(
                    ratingScore: (productReview["ratings"]?["average"] != 'NaN' &&
                        double.tryParse(productReview["ratings"]!["average"].toString()) != null)
                        ? double.tryParse(productReview["ratings"]!["average"].toString())?.toString() ?? '0'
                        : '0',

                    countRating: _getAmountRating(productReview: productReview),
                  ),

                  /// - Price, Title, Stock, Brand
                  CSProductMetaData(
                    productName: productData['name'] ?? 'Product Name',
                    price: productData['currentPrice']?.toString() ?? '0',
                    offPrice:  productData['vouchers'] != null && productData['vouchers'].isNotEmpty
                        ? '${productData['vouchers'][0]['value'] ?? 0}%'
                        : '0',
                    origin: productData['origin'] ?? 'From the VietNam Handcrafted',
                    status: "Loading",
                    // status: productData['status'] ?? 'Loading',
                  ),

                  /// - Attributes
                  CSProductAtributes(quantityRemain:productData["quantityRemain"] ?? 0,),

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
                       CSSectionHeading(title: 'Review(${_getAmountReview(productReview: productReview)})', showActionButton: false),
                      IconButton(
                        onPressed: () => Get.to(() =>  ProductReviewScreen(productReview: productReview ?? {},)),
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
