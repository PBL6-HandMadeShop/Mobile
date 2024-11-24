import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/cs_rounded_image.dart';
import '../../texts/cs_brand_title_text_with_vertified_icon.dart';
import '../../texts/product_title.dart';

class CSCartItem extends StatelessWidget {
  final String productName;
  final String productImage;
  final double productPrice;
  final int productQuantity;

  const CSCartItem({
    super.key,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Product Image
        CSRoundedImage(
          imageUrl: productImage,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(CSSize.sm),
          backgroundColor: CSHelperFunctions.isDarkMode(context)
              ? CSColors.darkerGrey
              : CSColors.light,
        ),
        const SizedBox(width: CSSize.spaceBtwItems),

        /// Product Info
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Brand Title
              const CsBrandTitleTextWithVertifiedIcon(title: 'Brand'), // Update dynamically if needed

              /// Product Name
              CSProductTitleText(
                title: productName,
                maxLines: 1,
              ),

              /// Price and Quantity
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Price: ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: '\$${productPrice.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const TextSpan(text: ' | '),
                    TextSpan(
                      text: 'Qty: ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: '$productQuantity',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
