import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/brand/card_brand.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import 'brand_products.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CSAppBar(title: Text('Brand'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSSize.defaultSpace),
          child: Column(
            children: [
              /// Heading
              const CSSectionHeading(title: 'Brands', showActionButton: false),
              const SizedBox(height: CSSize.spaceBtwItems),

              /// -- Brands
              CSGridLayout(
                itemCount: 10,
                mainAxisExtent: 80,
                itemBuilder: (context, index) => CSBrandCard(showBorder: true, onTap: () => Get.to(() => const BrandProducts()),),
              ),
            ], // Column children
          ),
        ),
      ),
    );
  }
}
