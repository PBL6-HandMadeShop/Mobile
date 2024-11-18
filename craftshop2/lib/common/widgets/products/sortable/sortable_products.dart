import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cart/product_cart_vertical.dart';

class CSSortableProducts extends StatelessWidget {
  const CSSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) {},
          items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity']
              .map((option) => DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ), // DropdownButtonFormField
        const SizedBox(height: CSSize.spaceBtwSections),

        /// Products
        // CSGridLayout(
        //   itemCount:8, // Specify the item count here,
        //   itemBuilder: (_, index) => const CSProductCardVertical(),
        // ), // TGridLayout
      ], // Column children
    );
  }
}
