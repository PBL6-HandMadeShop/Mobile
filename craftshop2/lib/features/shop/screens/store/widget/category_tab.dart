import 'package:flutter/cupertino.dart';

import '../../../../../common/brand/brand_showcase.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_cart/product_cart_vertical.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';

class CsCategoryTab extends StatefulWidget {
  final Map<String, dynamic>? productPage; // Accept product data as a parameter

  const CsCategoryTab({super.key, this.productPage});

  @override
  _CsCategoryTabState createState() => _CsCategoryTabState();
}

class _CsCategoryTabState extends State<CsCategoryTab> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // The data is passed directly to the widget, so no need to fetch again
  }

  @override
  Widget build(BuildContext context) {
    final productPage = widget.productPage;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(CSSize.defaultSpace),
          child: Column(
            children: [
              ///-- Brand
              // const CSBrandShowCase(
              //   images: [
              //     CSImage.product2,
              //     CSImage.product2,
              //     CSImage.product2,
              //   ],
              // ),
              // const CSBrandShowCase(
              //   images: [
              //     CSImage.product2,
              //     CSImage.product2,
              //     CSImage.product2,
              //   ],
              // ),
              // const SizedBox(height: CSSize.spaceBtwItems),
              ///-- Products
              CSSectionHeading(title: "You might like", showActionButton: true, onPressed: () {}),
              const SizedBox(height: CSSize.spaceBtwItems),

              CSGridLayout(
                itemCount: productPage?['content']?.length ?? 0,
                itemBuilder: (_, index) {
                  final productData = productPage?['content']?[index];
                  return productData != null
                      ? CSProductCardVertical(productData: productData)
                      : const SizedBox.shrink(); // In case no data is found
                },
              ),

              const SizedBox(height: CSSize.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
