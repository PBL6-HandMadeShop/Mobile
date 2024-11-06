import 'package:craftshop2/common/widgets/icons/cs_circular_icon.dart';
import 'package:craftshop2/utils/constants/colors.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';

class CSBottomAddToCart extends StatelessWidget {
  const CSBottomAddToCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final dark = CSHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: CSSize.defaultSpace, vertical: CSSize.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? CSColors.darkerGrey : CSColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(CSSize.cardRadiusLg),
          topRight: Radius.circular(CSSize.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CSCircularlIcon(
                icon: Iconsax.minus,
                backgroundColor: CSColors.darkerGrey,
                width: 40,
                height: 40,
                color: CSColors.white,
              ),
              const SizedBox(width: CSSize.spaceBtwItems),
              Text(
                '2',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(width: CSSize.spaceBtwItems),
              const CSCircularlIcon(
                icon: Iconsax.add,
                backgroundColor: CSColors.black,
                width: 40,
                height: 40,
                color: CSColors.white,
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(CSSize.md),
              backgroundColor: CSColors.black,
              side: const BorderSide(color: CSColors.black),
            ),
              child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
