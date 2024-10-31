import 'package:craftshop2/utils/constants/colors.dart';
import 'package:craftshop2/utils/device/device_utility.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CSTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CSTabBar({super.key, required this.tabs});
  final List<Widget> tabs; 
  @override
  Widget build(BuildContext context) {
    final dark= CSHelperFunctions.isDarkMode(context);
    return  Material(
      color: dark ? CSColors.black: CSColors.white,
      child: TabBar(tabs: tabs,
      isScrollable:  true,
      indicatorColor:   CSColors.primaryColor,
        labelColor: dark ? CSColors.white : CSColors.black,
        unselectedLabelColor: CSColors.darkgrey,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(CSDeviceUtils.getAppBarHeight());
}
