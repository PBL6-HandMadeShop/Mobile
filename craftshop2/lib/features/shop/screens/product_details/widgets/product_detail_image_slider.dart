import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shape/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/cs_circular_icon.dart';
import '../../../../../common/widgets/images/cs_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';

class CSProductImageSlider extends StatelessWidget {
  const CSProductImageSlider({
    super.key,
  });
  

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return CSCurvedEdgeWidget(
      child: Container(
        color: dark ? CSColors.darkerGrey: CSColors.light,
        child: Stack(
          children: [
            ///Main image
            SizedBox(height: 400, child: Padding(
              padding: EdgeInsets.all(CSSize.productImageRadius * 2),
              child: Center(child: Image(image: AssetImage(CSImage.product1))),
            ),
            ),

            ///Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: CSSize.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) => CSRoundedImage(
                      width:  80,
                      backgroundColor: dark ? CSColors.dark : CSColors.light,
                      border: Border.all(color: CSColors.primaryColor),
                      padding: const EdgeInsets.all(CSSize.sm),
                      imageUrl: CSImage.product3,
                    ),
                    separatorBuilder: (_,__) => const SizedBox(width: CSSize.spaceBtwItems),
                    itemCount: 4
                ),
              ),
            ),

            ///Appbar Icons
            const CSAppBar(
              showBackArrow: true,
              actions: [CSCircularlIcon(icon: Iconsax.heart5, color: Colors.red),],
            ),
          ],
        ),
      ),
    );
  }
}