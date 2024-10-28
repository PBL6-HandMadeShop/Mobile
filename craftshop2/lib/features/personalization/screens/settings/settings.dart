import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart ';

import '../../../../common/widgets/custom_shape/containers/primary_header_container.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';

class SettingsScreen extends StatelessWidget{
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
                child: Column(
                    children: [
                      /// AppBar
                      TAppBar(title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white))),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      ///User Profile Card
                      const TUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),
                      const SizedBox(height: TSizes.spaceBtwSections),
                ],
            ` ),
            ),
            const Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                    children:[
                      TSectionHeading(title: 'Account Settings'),
                      SizedBox(height: TSizes.spaceBtwItems),

                      TSettingsMenuTile(icon: Iconsax.safe_home, title: 'My Addresses', subTitle: 'Set shopping delivery adress', onTab(){}),
                      TSettingsMenuTile(icon: Iconsax.shopping_cart, title: 'My Cart', subTitle: 'Add, remove product adn move to checkout', onTab(){}),
                      TSettingsMenuTile(icon: Iconsax.bag_tick, title: 'My Orders ', subTitle: 'In-progress and Completed Orders', onTab(){}),
                      TSettingsMenuTile(icon: Iconsax.bank, title: 'Bank Account', subTitle: 'Withdraw balance to registered bank account', onTab(){}),
                      TSettingsMenuTile(icon: Iconsax.discount_shape, title: 'My Coupons', subTitle: 'List of all the discounted coupons', onTab(){}),
                      TSettingsMenuTile(icon: Iconsax.notification, title: 'Notifications', subTitle: 'Set any kind of notification message', onTab(){}),
                      TSettingsMenuTile(icon: Iconsax.security_card, title: 'Account Privacy', subTitle: 'manage data usage and connected accounts', onTab(){}),

                      /// -- App Settings
                      SizedBox(height: TSizes.spaceBtwSections),
                      TSectionHeading(title: 'App Setting', showActionButton: false),
                      SizedBox(height: TSizes.spaceBtwItems),
                      TSettingsMenuTile(icon: Iconsax.document_upload, title: 'load data', subTitle:'Upload Data to your cloud Fisebase'),
                      TSettingsMenuTile(icon: Iconsax.location, title: 'location', subTitle:'Set recommendation based on location', trailing: Switch(value: true, onChanged: (value){})),
                      TSettingsMenuTile(icon: Iconsax.security_user, title: 'Safe Mode', subTitle:'Search result is safe for all age', trailing: Switch(value: false, onChanged: (value){})),
                      TSettingsMenuTile(icon: Iconsax.image, title: 'HD Image Quality', subTitle:'Set image quality to be seen', trailing: Switch(value: false, onChanged: (value){})),

                    ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}

