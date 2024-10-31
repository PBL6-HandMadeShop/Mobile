import 'package:craftshop2/common/widgets/layouts/grid_layout.dart';
import 'package:craftshop2/common/widgets/products/product_cart/product_cart_vertical.dart';
import 'package:craftshop2/common/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';

import '../../../../../common/brand/brand_showcase.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';

class CsCategoryTab extends StatelessWidget {
  const CsCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(CSSize.defaultSpace),
          child: Column(
            children: [
              ///-- Brand
              const CSBrandShowCase(
                images: [
                  CSImage.product2,
                  CSImage.product2,
                  CSImage.product2,
                ],
              ), const CSBrandShowCase(
                images: [
                  CSImage.product2,
                  CSImage.product2,
                  CSImage.product2,
                ],
              ),
              const SizedBox(height: CSSize.spaceBtwItems,),
              ///-- Products
              CSSectionHeading(title: "You might like", showActionButton: true, onPressed: (){}),
              const SizedBox(height: CSSize.spaceBtwItems,),

              CSGridLayout(itemCount: 4, itemBuilder: (_, index) => const CSProductCardVertical()),
              const SizedBox(height: CSSize.spaceBtwSections,),
            ],
          ),
        ),
      ],
    );
  }
}
