
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';
import '../widgets/custom_shape/containers/rounded_container.dart';
import 'card_brand.dart';

class CSBrandShowCase extends StatelessWidget {
  const CSBrandShowCase({
    super.key, required this.images,
  });
  final List<String> images ;
  @override
  Widget build(BuildContext context) {
    return CSRoundedContainer(
      showBorder: true,
      borderColor: CSColors.darkgrey,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(CSSize.md),
      margin: const EdgeInsets.only(bottom: CSSize.spaceBtwItems),
      child: Column(
        /// Brand with products count
        children: [
          const CSBrandCard(showBorder: false),
          const SizedBox(height: CSSize.spaceBtwItems,),          ///Brand top 3 products images
          Row(
            children: images.map((image) => brandTopProductImageWidget(image, context)).toList(),

          ),
        ],
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image, context){
  return Expanded(child: CSRoundedContainer(
    height: 100,
    backgroundColor: CSHelperFunctions.isDarkMode(context) ? CSColors.darkgrey: CSColors.light,
    margin: const EdgeInsets.only(right: CSSize.sm),
    padding: const EdgeInsets.all(CSSize.md),
    child:  Image(fit: BoxFit.contain,image: AssetImage(image)),
  ),);
}