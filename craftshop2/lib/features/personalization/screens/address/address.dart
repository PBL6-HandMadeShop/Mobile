import 'package:craftshop2/features/personalization/screens/address/widgets/single_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import 'add_new_address.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: CSColors.primaryColor,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Iconsax.add, color: CSColors.white),
      ), // FloatingActionButton
      appBar: CSAppBar(
        showBackArrow: true,
        title: Text('Addresses', style: Theme.of(context).textTheme.headlineSmall),
      ), // TAppBar
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CSSize.defaultSpace),
          child: Column(
            children: [
              // Add your children widgets here
              CSSingleAddress(selectedAddress: true,),
              CSSingleAddress(selectedAddress: false,),
              CSSingleAddress(selectedAddress: false,),
              CSSingleAddress(selectedAddress: false,),
            ],
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
