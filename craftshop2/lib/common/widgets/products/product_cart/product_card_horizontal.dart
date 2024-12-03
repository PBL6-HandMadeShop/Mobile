import 'package:craftshop2/common/styles/shadows.dart';
import 'package:craftshop2/common/widgets/custom_shape/containers/rounded_container.dart';
import 'package:craftshop2/common/widgets/icons/cs_circular_icon.dart';
import 'package:craftshop2/common/widgets/images/cs_rounded_image.dart';
import 'package:craftshop2/common/widgets/texts/cs_brand_title_text_with_vertified_icon.dart';
import 'package:craftshop2/utils/constants/colors.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title.dart';

class CSProductCardHorizontal extends StatelessWidget {
  const CSProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);

    return Container(
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
                const SizedBox(
                  height: 120,
                  width: 120,
                  child: CSRoundedImage(imageUrl: CSImage.product1, applyImageRadius: true),
                ), // SizedBox

                /// -- Sale Tag
                Positioned(
                  top: 12,
                  child: CSRoundedContainer(
                    radius: CSSize.sm,
                    backgroundColor: CSColors.secondaryColor.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(horizontal: CSSize.sm, vertical: CSSize.xs),
                    child: Text('25%', style: Theme.of(context).textTheme.labelLarge!.apply(color: CSColors.black)),
                  ), // TRoundedContainer
                ), // Positioned

                /// -- Favourite Icon Button
                const Positioned(
                  top: 0,
                  right: 0,
                  child: CSCircularlIcon(icon: Iconsax.heart5, color: Colors.red),
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CSProductTitleText(title: 'Green Nike Half Sleeves Shirt', smallSize: true),
                      SizedBox(height: CSSize.spaceBtwItems / 2),
                      CsBrandTitleTextWithVertifiedIcon(title: 'Nike'),
                    ], // Column children
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Pricing
                      const Flexible(child: CSProductPriceText(price: '256.0')),

                      /// Add to cart
                      Container(
                        decoration: const BoxDecoration(
                          color: CSColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(CSSize.cardRadiusMd),
                            bottomRight: Radius.circular(CSSize.productImageRadius),
                          ), // BorderRadius.only
                        ), // BoxDecoration
                        child: const SizedBox(
                          width: CSSize.iconLg * 1.2,
                          height: CSSize.iconLg * 1.2,
                          child: Center(child: Icon(Iconsax.add, color: CSColors.white)),
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
    );
  }
}
