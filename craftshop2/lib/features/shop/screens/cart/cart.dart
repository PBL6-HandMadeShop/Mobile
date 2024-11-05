import 'package:craftshop2/common/widgets/appbar/appbar.dart';
import 'package:craftshop2/common/widgets/icons/cs_circular_icon.dart';
import 'package:craftshop2/common/widgets/texts/cs_brand_title_text_with_vertified_icon.dart';
import 'package:craftshop2/common/widgets/texts/product_price_text.dart';
import 'package:craftshop2/common/widgets/texts/product_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/images/cs_rounded_image.dart';
import '../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(CSSize.defaultSpace),
        child: CSCartItem(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(CSSize.defaultSpace),
        child: ElevatedButton(onPressed: () => Get.to(() => const CheckoutScreen()), child: Text('Checkout \$256.0')),
      ),
    ); // Scaffold
  }
}


