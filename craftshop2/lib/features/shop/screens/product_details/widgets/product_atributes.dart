import 'package:craftshop2/common/widgets/custom_shape/containers/rounded_container.dart';
import 'package:craftshop2/common/widgets/texts/product_price_text.dart';
import 'package:craftshop2/common/widgets/texts/product_title.dart';
import 'package:craftshop2/common/widgets/texts/section_heading.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class CSProductAtributes extends StatelessWidget{
  const CSProductAtributes({super.key, required this.quantityRemain});
  final int quantityRemain;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final dark = CSHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        CSRoundedContainer(
          padding:  const EdgeInsets.all(CSSize.md),
          backgroundColor: dark ? CSColors.darkerGrey : CSColors.white,
          child: Column(
            children: [
              // Row(
              //   children: [
              //     const CSSectionHeading(title: 'Variation', showActionButton: false),
              //     const SizedBox(width: CSSize.spaceBtwItems),
              //
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const CSProductTitleText(title: 'price', smallSize: true),
              //         /// Actual Price
              //         Row(
              //           children: [
              //             Text(
              //               '\$25',
              //               style:  Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),
              //             ),
              //             const SizedBox(width: CSSize.spaceBtwItems),
              //         ///Sale Price
              //             CSProductPriceText(price: '20'),
              //           ],
              //         ),
              //
              //         ///Stock
              //         Row(
              //           children: [
              //             const CSProductTitleText(title: 'Stock', smallSize: true),
              //             const SizedBox(width: CSSize.spaceBtwItems),
              //             Text("$quantityRemain", style:  Theme.of(context).textTheme.titleMedium),
              //           ],
              //         ),
              //       ],
              //     ),
              //
              //   ],
              // ),
              Row(
                children: [
                  const CSProductTitleText(title: 'Stock', smallSize: true),
                  const SizedBox(width: CSSize.spaceBtwItems),
                  Text("$quantityRemain", style:  Theme.of(context).textTheme.titleMedium),
                ],
              ),
              /// variation Descriptiom
              // CSProductTitleText(
              //   title: 'This is the Description of the Product and it can go upto max 4 lines',
              //   smallSize: true,
              //   maxLines: 4,
              // ),
            ],
          ),
        ),
        const SizedBox(height: CSSize.spaceBtwItems),

        /// -Atribute
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     const CSSectionHeading(title: 'color', showActionButton: false),
        //     const SizedBox(height: CSSize.spaceBtwItems/2),
        //     Wrap(
        //       spacing: 8,
        //       children: [
        //         CSChoicChip(text: 'Green', selected: false, onSelected: (value){},),
        //         CSChoicChip(text: 'Blue', selected: true,onSelected: (value){}),
        //         CSChoicChip(text: 'Yellow', selected: false,onSelected: (value){}),
        //       ],
        //     )
        //   ],
        // ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     const CSSectionHeading(title: 'Size'),
        //     const SizedBox(height: CSSize.spaceBtwItems/2),
        //     Wrap(
        //       spacing: 8,
        //       children: [
        //         CSChoicChip(text: 'EU 34', selected: true, onSelected: (value){}),
        //         CSChoicChip(text: 'EU 36', selected: false, onSelected: (value){}),
        //         CSChoicChip(text: 'EU 38', selected: false, onSelected: (value){}),
        //       ],
        //     )
        //   ],
        // ),
      ],
    );
  }
}

