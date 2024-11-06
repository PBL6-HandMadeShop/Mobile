import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../icons/cs_circular_icon.dart';

class CSProductQuanityWithAddRemoveButton extends StatelessWidget {
  const CSProductQuanityWithAddRemoveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CSCircularlIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: CSSize.md,
          color: CSHelperFunctions.isDarkMode(context) ? CSColors.white : CSColors.black,
          backgroundColor: CSHelperFunctions.isDarkMode(context) ? CSColors.darkerGrey : CSColors.light,
        ), // TCircularIcon
        const SizedBox(width: CSSize.spaceBtwItems),
        Text('2', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: CSSize.spaceBtwItems),

        const CSCircularlIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: CSSize.md,
          color: CSColors.white,
          backgroundColor: CSColors.primaryColor,
        ), // TCircularIcon
      ], // Row children
    );
  }
}

