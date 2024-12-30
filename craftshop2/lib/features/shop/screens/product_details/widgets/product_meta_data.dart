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
    super.key, required this.price, required this.offPrice, required this.origin, required this.productName,
});
  final String productName;
  final String price;
  final String offPrice;
  // final String basePrice;
  final String origin;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final darkMode = CSHelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(

              child: CsBrandTitleTextWithVertifiedIcon(title: productName, brandTextSize: TextSizes.large
                , textColor: CSColors.black,)
              ,
            ),
          ],
        ),
        const SizedBox(height: CSSize.spaceBtwSections),
        /// Price & Sale Price
        Row(
          children: [
            ///Sale Tag
            CSRoundedContainer(
              radius: CSSize.sm,
              backgroundColor: CSColors.secondaryColor.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(horizontal: CSSize.sm, vertical: CSSize.xs),
              child: Text( '$offPrice%', style: Theme.of(context).textTheme.labelLarge!.apply(color: CSColors.white)),
            ),
            const SizedBox(width: CSSize.spaceBtwItems),
            ///Price
            CSProductPriceText(price: price, isLarge: false),
            const SizedBox(width: CSSize.spaceBtwItems),
          ],
        ),
        const SizedBox(height: CSSize.spaceBtwItems/1.5),
        /// Title
        CSProductTitleText(title: origin ?? 'From the VietNam Handcrafted'),
        const SizedBox(height: CSSize.spaceBtwItems/1.5),
        /// Stock

        const SizedBox(height: CSSize.spaceBtwItems/1.5),
        /// Brand

      ],
    );
  }
}