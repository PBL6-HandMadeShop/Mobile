import 'package:craftshop2/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:craftshop2/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:craftshop2/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:craftshop2/features/authencation/models/user_model.dart'; // Import UserInfo model
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shape/containers/rounded_container.dart';
import '../../../../common/widgets/products/cart/coupoun_widget.dart';
import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/http/api_service.dart';
import '../../../personalization/models/user_info.dart';
import '../cart/widgets/cart_items.dart';
import 'package:craftshop2/api_services/api_services.dart'; // Import API service

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
                    FutureBuilder<UserInfo>(
                      future: fetchUserInfo(), // Call the function to fetch user info
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Show loading while fetching data
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}'); // Show error message
                        } else if (snapshot.hasData) {
                          UserInfo userInfo = snapshot.data!;
                          return CSBillingAddressSection(userInfo: userInfo); // Pass user info to the widget
                        } else {
                          return const Text('No user info available');
                        }
                      },
                    ),
                    const SizedBox(height: CSSize.spaceBtwItems),
                  ], // Column children
                ), // Column
              ), // CSRoundedContainer
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
            ),
          ),
          child: Text('Checkout \$256.0'),
        ),
      ),
    );
  }

  // Function to fetch user information from API
  Future<UserInfo> fetchUserInfo() async {
    final apiService = API_Services();
    final response = await apiService.fetchUserInfo(); // Call the API service
    return UserInfo.fromJson(response); // Parse the API response to UserInfo object
  }
}
