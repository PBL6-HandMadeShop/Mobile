import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/cs_rounded_image.dart';
import '../../../../common/widgets/products/product_cart/product_card_horizontal.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, this.productPage});
  final Map<String, dynamic>? productPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CSAppBar(title: Text("${productPage?["name"]}" ?? "No name"), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSSize.defaultSpace),
          child: Column(
            children: [
              /// Banner
              // const CSRoundedImage(
              //   width: double.infinity,
              //   imageUrl: CSImage.promoBanner3,
              //   applyImageRadius: true,
              // ),
              const SizedBox(height: CSSize.spaceBtwSections),

              /// Sub-Categories
              Column(
                children: [
                  /// Heading
                  CSSectionHeading(title: "${productPage?["name"]}" ?? "No name", onPressed: () {}),
                  const SizedBox(height: CSSize.spaceBtwItems / 2),

                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: productPage?["producs"].length ?? 0,

                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(width: CSSize.spaceBtwItems,),
                      itemBuilder: (_, index) {
                        final productData = productPage?["producs"][index];
                        return productData != null
                            ? CSProductCardHorizontal(productData: productData)
                            :const SizedBox.shrink(); // In case no data is found
                      },
                    ),
                  ), // ListView.builder
                ], // Column children
              ), // Column
            ], // Column children
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
