import 'package:craftshop2/utils/constants/colors.dart';
import 'package:craftshop2/utils/constants/sizes.dart';
import 'package:craftshop2/utils/device/device_utility.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CSAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CSAppBar({super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed});

  final Widget? title;

  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return Padding(padding: const EdgeInsets.symmetric(horizontal: CSSize.md),
      child: AppBar(
      automaticallyImplyLeading: false,
      leading:showBackArrow
          ? IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.arrow_left), color:  dark ? CSColors.white : CSColors.dark)
              :leadingIcon != null ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon)): null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(CSDeviceUtils.getAppBarHeight());
}
