import 'package:craftshop2/common/widgets/appbar/appbar.dart';
import 'package:craftshop2/common/widgets/icons/cs_circular_icon.dart';
import 'package:craftshop2/features/shop/screens/home/home.dart';
import 'package:craftshop2/utils/constants/sizes.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CSAppBar(
        title: Text("Wishlist", style: Theme.of(context).textTheme.headlineMedium,),
        actions: [
          CSCircularlIcon( icon: Iconsax.add, onPressed: () => Get.to(const HomeScreen())),
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(CSSize.defaultSpace),
        child: Column(
          children: [
            // CSGridLayout(itemCount: 4, itemBuilder: (_,index) => const CSProductCardVertical()),
          ],
        ),),
      ),
    );
  }
}
