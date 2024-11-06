import 'package:craftshop2/common/widgets/appbar/appbar.dart';
import 'package:craftshop2/common/widgets/icons/cs_circular_icon.dart';
import 'package:craftshop2/common/widgets/images/cs_rounded_image.dart';
import 'package:craftshop2/common/widgets/texts/section_heading.dart';
import 'package:craftshop2/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:craftshop2/features/shop/screens/product_details/widgets/product_atributes.dart';
import 'package:craftshop2/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:craftshop2/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:craftshop2/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:craftshop2/utils/constants/colors.dart';
import 'package:craftshop2/utils/constants/image_string.dart';
import 'package:craftshop2/utils/constants/sizes.dart';
import 'package:craftshop2/utils/theme/custom_themes/bottem_sheet_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../../common/widgets/custom_shape/curved_edges/curved_edges_widget.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../product_reviews/product_reviews.dart';

class ProductDetailScreen extends StatelessWidget{
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: const CSBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///1 - Product Image Slider
          CSProductImageSlider(),

            /// 2 - Product Details
            Padding(
                padding: EdgeInsets.only(right: CSSize.defaultSpace, left: CSSize.defaultSpace, bottom: CSSize.defaultSpace),
                child: Column(
                  children: [
                    /// - Rating & share
                    CSRatingAndShare(),

                    /// - Price, Title, Stock, Brand
                    CSProductMetaData(),

                    /// - Atributes
                    CSProductAtributes(),
                    const SizedBox(height: CSSize.spaceBtwSections),

                    /// - Checkout Button
                    SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){}, child: Text('Checkout'))),
                    const SizedBox(height: CSSize.spaceBtwSections),
                    /// - Description
                    const CSSectionHeading(title: 'Description', showActionButton: false),
                    const SizedBox(height: CSSize.spaceBtwItems),
                    ReadMoreText(
                      'This is a Product description for Blue Nike Slevee less vest. There more things that can be add but i am the one that can be it',
                      trimLines : 2,
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
                        const CSSectionHeading(title: 'Review(199)', showActionButton: false,),
                        IconButton(onPressed: () => Get.to(() => const ProductReviewScreen()), icon: const Icon(Iconsax.arrow_right_3, size: 18)),
                      ],
                    ),
                    const SizedBox(height: CSSize.spaceBtwSections),
                  ],
                ),
            )

          ],
        ),
      ),
    );
  }
}



