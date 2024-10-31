
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

class CSSearchContainer extends StatelessWidget {
  const CSSearchContainer({
    super.key, required this.text, this.icon = Iconsax.search_normal,  this.showBackground = true,  this.showBorder = true, this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: CSSize.defaultSpace),
  });
  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: CSDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(CSSize.md),
          decoration: BoxDecoration(
            color:showBackground ? dark? CSColors.dark : CSColors.light : Colors.transparent,
            borderRadius: BorderRadius.circular(CSSize.cardRadiusLg),
            border:showBorder? Border.all(color: CSColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: CSColors.black,),
              const SizedBox(width: CSSize.spaceBtwItems,),
              Text(text, style: Theme.of(context).textTheme.bodySmall!.apply(color: CSColors.darkgrey),),
            ],
          ),
        ),
      ),
    );
  }
}
