  import 'package:craftshop2/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:craftshop2/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:craftshop2/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shape/containers/rounded_container.dart';
import '../../../../common/widgets/products/cart/coupoun_widget.dart';
import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../cart/widgets/cart_items.dart';

  class CheckoutScreen extends StatelessWidget {
    const CheckoutScreen({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      final dark = CSHelperFunctions.isDarkMode(context);

      return Scaffold(
        appBar: CSAppBar(
          showBackArrow: true,
          title: Text('Order Review', style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(CSSize.defaultSpace),
            child: Column(
              children: [
                /// -- Items in Cart
                const CSCartItems(showAddRemoveButton: false),
                const SizedBox(height: CSSize.spaceBtwSections),

                /// -- Coupon TextField
                CSCouponCode(),
                const SizedBox(height: CSSize.spaceBtwSections),

                /// -- Billing Section
                CSRoundedContainer(
                  showBorder: true,
                  backgroundColor: dark ? CSColors.black : CSColors.white,
                  child: Column(
                    children: [
                      /// Pricing
                      CSBillingAmountSection(),
                      const SizedBox(height: CSSize.spaceBtwItems),

                      /// Divider
                      const Divider(),
                      const SizedBox(height: CSSize.spaceBtwItems),

                      /// Payment Methods
                      CSBillingPaymentSection(),
                      const SizedBox(height: CSSize.spaceBtwItems),
                      /// Address
                      CSBillingAddressSection(),
                    ], // Column children
                  ), // Column
                ), // TRoundedContainer

              ], // Column children
            ), // Column
          ), // Padding
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(CSSize.defaultSpace),
          child: ElevatedButton(
              onPressed: () => Get.to(
                    () => SuccessScreen(
                  image: CSImage.sculpture,
                  title: 'Payment Success!',
                  subTitle: 'Your item will be shipped soon!',
                  onPressed: () => Get.offAll(() => const NavigationMenu()),
                ), // SuccessScreen
              ),

              child: Text('Checkout \$256.0')),
        ),// SingleChildScrollView
      ); // Scaffold
    }
  }


