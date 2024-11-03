import 'package:craftshop2/common/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart ';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shape/containers/primary_header_container.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../address/address.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget{
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CSPrimaryHeaderContainer(
                child: Column(
                    children: [
                      /// AppBar
                      CSAppBar(title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: CSColors.white))),
                      const SizedBox(height: CSSize.spaceBtwSections),

                      ///User Profile Card
                      CSUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),
                      const SizedBox(height: CSSize.spaceBtwSections),
                ],
            ),
            ),
            Padding(
                padding: const EdgeInsets.all(CSSize.defaultSpace),
                child: Column(
                    children:[
                      const CSSectionHeading(title: 'Account Settings'),
                      const SizedBox(height: CSSize.spaceBtwItems),

                      CSSettingsMenuTile(icon: Iconsax.safe_home, title: 'My Addresses', subTitle: 'Set shopping delivery adress', onTab: () => Get.to(() => const UserAddressScreen())),
                      CSSettingsMenuTile(icon: Iconsax.shopping_cart, title: 'My Cart', subTitle: 'Add, remove product adn move to checkout',onTab: (){}),
                      CSSettingsMenuTile(icon: Iconsax.bag_tick, title: 'My Orders ', subTitle: 'In-progress and Completed Orders', onTab: (){}),
                      CSSettingsMenuTile(icon: Iconsax.bank, title: 'Bank Account', subTitle: 'Withdraw balance to registered bank account', onTab: (){}),
                      CSSettingsMenuTile(icon: Iconsax.discount_shape, title: 'My Coupons', subTitle: 'List of all the discounted coupons',onTab: (){}),
                      CSSettingsMenuTile(icon: Iconsax.notification, title: 'Notifications', subTitle: 'Set any kind of notification message', onTab: (){}),
                      CSSettingsMenuTile(icon: Iconsax.security_card, title: 'Account Privacy', subTitle: 'manage data usage and connected accounts', onTab: (){}),

                      // -- App Settings
                      const SizedBox(height: CSSize.spaceBtwSections),
                      const CSSectionHeading(title: 'App Setting', showActionButton: false),
                      const SizedBox(height: CSSize.spaceBtwItems),
                      const CSSettingsMenuTile(icon: Iconsax.document_upload, title: 'Load data', subTitle:'Upload Data to your cloud Fisebase'),
                      CSSettingsMenuTile(icon: Iconsax.location, title: 'Location', subTitle:'Set recommendation based on location', trailing: Switch(value: true, onChanged: (value){})),
                      CSSettingsMenuTile(icon: Iconsax.security_user, title: 'Safe Mode', subTitle:'Search result is safe for all age', trailing: Switch(value: false, onChanged: (value){})),
                      CSSettingsMenuTile(icon: Iconsax.image, title: 'HD Image Quality', subTitle:'Set image quality to be seen', trailing: Switch(value: false, onChanged: (value){})),

                    ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}

