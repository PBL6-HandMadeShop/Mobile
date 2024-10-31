import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/enums.dart';
import '../../utils/constants/image_string.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';
import '../widgets/custom_shape/containers/rounded_container.dart';
import '../widgets/images/cs_circular_image.dart';
import '../widgets/texts/cs_brand_title_text_with_vertified_icon.dart';

class CSBrandCard extends StatelessWidget {
  const CSBrandCard({
    super.key, required this.showBorder, this.onTap,
  });
  final bool showBorder;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CSRoundedContainer(padding:const EdgeInsets.all(CSSize.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            /// icon
            Flexible(
              child: CSCircularImage(image: CSImage.pottery,
                isNetworkImage: false,
                backgroundColor: Colors.transparent,
                overlayColor: CSHelperFunctions.isDarkMode(context) ? CSColors.white : CSColors.black,),
            ),
            const SizedBox(width: CSSize.spaceBtwItems/2,),

            /// text
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CsBrandTitleTextWithVertifiedIcon(title: 'Thanh Ha',brandTextSize: TextSizes.large, ),
                  Text("256 products",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,)
                ],
              ),
            ),
          ],
        ),),
    );
  }
}
