import 'package:craftshop2/common/styles/shadows.dart';
import 'package:craftshop2/common/widgets/custom_shape/containers/rounded_container.dart';
import 'package:craftshop2/common/widgets/images/cs_rounded_image.dart';
import 'package:craftshop2/features/shop/screens/product_details/product_detail.dart';
import 'package:craftshop2/utils/constants/colors.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';

class CSProductCardVertical extends StatelessWidget{
  const CSProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final dark = CSHelperFunctions.isDarkMode(context);

    ///Container with side padding, color, edges, radius, shadow
    return GestureDetector(
      onTap: () => Get.to(() => const ProductDetailScreen()),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [CSShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(CSSize.productImageRadius),
          color: dark ? CSColors.darkerGrey : CSColors.white,
        ),
        child: Column(
          children: [
            ///thumbnail, wishlist Button, discount Tag
            CSRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(CSSize.sm),
              backgroundColor: dark ? CSColors.dark : CSColors.light,
              child: Stack(
                children: [
                  /// --thumbnail Image
                  const CSRoundedImage(imageUrl: CSImage.product1, applyImageRadius: true),

                  /// - sale Tag
                  Positioned(
                      top: 12,
                      child: CSRoundedContainer(
                        radius: CSSize.sm,
                        backgroundColor: CSColors.secondaryColor.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(horizontal: CSSize.sm, vertical: CSSize.xs),
                        child: Text('25%', style: Theme.of(context).textTheme.labelLarge!.apply(color: CSColors.white)),
                        ),
                      ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}