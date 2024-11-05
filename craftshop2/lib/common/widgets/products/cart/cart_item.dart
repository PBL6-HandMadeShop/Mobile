import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/cs_rounded_image.dart';
import '../../texts/cs_brand_title_text_with_vertified_icon.dart';
import '../../texts/product_title.dart';

class CSCartItem extends StatelessWidget {
  const CSCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Image
        CSRoundedImage(
          imageUrl: CSImage.product1,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(CSSize.sm),
          backgroundColor: CSHelperFunctions.isDarkMode(context)
              ? CSColors.darkerGrey
              : CSColors.light,
        ), // TRoundedImage
        const SizedBox(width: CSSize.spaceBtwItems),

        /// Title, Price, & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CsBrandTitleTextWithVertifiedIcon(title: 'Nike'),
              Flexible(
                child: const CSProductTitleText(
                  title: 'Black Sports shoes ',
                  maxLines: 1,
                ),
              ), // TProductTitleText

              /// Attributes
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Color ', style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: 'Green ', style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(text: 'Size ', style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: 'UK 08 ', style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ), // TextSpan
              ), // Text.rich
            ], // Column children
          ),
        ),
      ], // Row
    );
  }
}