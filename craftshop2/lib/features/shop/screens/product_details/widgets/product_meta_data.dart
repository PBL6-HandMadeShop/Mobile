import 'package:craftshop2/common/widgets/images/cs_circular_image.dart';
import 'package:craftshop2/common/widgets/texts/cs_brand_title_text_with_vertified_icon.dart';
import 'package:craftshop2/common/widgets/texts/product_price_text.dart';
import 'package:craftshop2/common/widgets/texts/product_title.dart';
import 'package:craftshop2/utils/constants/enums.dart';
import 'package:craftshop2/utils/constants/image_string.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_shape/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class CSProductMetaData extends StatelessWidget{
  const CSProductMetaData({
    super.key,
});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final darkMode = CSHelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            ///Sale Tag
            CSRoundedContainer(
              radius: CSSize.sm,
              backgroundColor: CSColors.secondaryColor.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(horizontal: CSSize.sm, vertical: CSSize.xs),
              child: Text('25%', style: Theme.of(context).textTheme.labelLarge!.apply(color: CSColors.white)),
            ),
            const SizedBox(width: CSSize.spaceBtwItems),
            ///Price
            Text('\$250', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough)),
            const SizedBox(width: CSSize.spaceBtwItems),
            const CSProductPriceText(price: '175', isLarge: true),
            const SizedBox(width: CSSize.spaceBtwItems),
          ],
        ),
        const SizedBox(height: CSSize.spaceBtwItems/1.5),
        /// Title
        CSProductTitleText(title: 'Green Nike Sports Shirt'),
        const SizedBox(height: CSSize.spaceBtwItems/1.5),
        /// Stock
        Row(
          children: [
            const CSProductTitleText(title: 'Status'),
            const SizedBox(width: CSSize.spaceBtwItems),
            Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: CSSize.spaceBtwItems/1.5),
        /// Brand
        Row(
          children: [
            CSCircularImage(
                image: CSImage.verify,
                width: 32,
                height: 32,
                overlayColor: darkMode ? CSColors.white : CSColors.black,
            ),
            const CsBrandTitleTextWithVertifiedIcon(title: 'Nike', brandTextSize: TextSizes.medium),
          ],
        ),
      ],
    );
  }
}