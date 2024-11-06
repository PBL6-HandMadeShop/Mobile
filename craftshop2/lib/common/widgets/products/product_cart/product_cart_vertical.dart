import 'package:craftshop2/common/styles/shadows.dart';
import 'package:craftshop2/common/widgets/custom_shape/containers/rounded_container.dart';
import 'package:craftshop2/common/widgets/images/cs_rounded_image.dart';
import 'package:craftshop2/utils/constants/colors.dart';
import 'package:craftshop2/utils/constants/image_string.dart';
import 'package:craftshop2/utils/constants/sizes.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../icons/cs_circular_icon.dart';
import '../../texts/cs_brand_title_text_with_vertified_icon.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title.dart';

class CSProductCardVertical extends StatelessWidget {
  const CSProductCardVertical({super.key});

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
            color: dark ? CSColors.darkgrey : CSColors.white),
        child: Column(
          children: [
            /// thumbnail, wishlist button, discount tag
            CSRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(CSSize.sm),
              backgroundColor: dark ? CSColors.dark : CSColors.light,
              child: Stack(
                children: [
                  /// thumbnail
                  const CSRoundedImage(
                    imageUrl: CSImage.product1,
                    applyImageRadius: true,
                  ),

                  /// sale tag
                  Positioned(
                    top: 12,
                    child: CSRoundedContainer(
                      padding: const EdgeInsets.symmetric(
                          horizontal: CSSize.sm, vertical: CSSize.xs),
                      radius: CSSize.sm,
                      backgroundColor: CSColors.secondaryColor.withOpacity(0.8),
                      child: Text(
                        '20% OFF',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: CSColors.black),
                      ),
                    ),
                  ),

                  /// wishlist button
                  Positioned(
                      top: 0,
                      right: 0,
                      child: CSCircularlIcon(
                        icon: Iconsax.heart5,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: CSSize.spaceBtwItems / 2,
            ),
            const Padding(
              padding: EdgeInsets.only(left: CSSize.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CSProductTitleText(
                    title: "Binh Gom Doi",
                    smallSize: true,
                  ),
                  SizedBox(
                    height: CSSize.spaceBtwItems / 2,
                  ),
                  CsBrandTitleTextWithVertifiedIcon(title: 'Do gom cho moi nha', ),
                  // const Spacer(),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //price
                const Padding(
                  padding: EdgeInsets.only(left: CSSize.sm),
                  child: CSProductPriceText(price: '200K',),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: CSColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(CSSize.cardRadiusMd),
                      bottomRight:
                      Radius.circular(CSSize.productImageRadius),
                    ),
                  ),
                  child: const SizedBox(
                      width: CSSize.iconLg * 1.2,
                      height: CSSize.iconLg * 1.2,
                      child:  Center(
                        child: Icon(
                          Iconsax.add,
                          color: CSColors.white,
                        ),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}


