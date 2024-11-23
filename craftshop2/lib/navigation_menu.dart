import 'package:craftshop2/features/shop/screens/checkout/checkout.dart';
import 'package:craftshop2/features/shop/screens/home/home.dart';
import 'package:craftshop2/features/shop/screens/store/store.dart';
import 'package:craftshop2/features/shop/screens/wishlist/wishlist.dart';
import 'package:craftshop2/utils/constants/colors.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/personalization/screens/settings/settings.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});



  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigatonController());
    final darkMode = CSHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        ()=> NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) => controller.selectedIndex.value = index,
            backgroundColor: darkMode ? CSColors.black: CSColors.white,
            indicatorColor: darkMode ? CSColors.white.withOpacity(0.1): CSColors.black.withOpacity(0.1),
            destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
          NavigationDestination(icon: Icon(Iconsax.shop), label: "Store"),
          NavigationDestination(icon: Icon(Iconsax.heart), label: "Wish List"),
          NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
        ]),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigatonController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens =[const HomeScreen(), Store(), const FavoriteScreen(), const SettingsScreen()];
}
