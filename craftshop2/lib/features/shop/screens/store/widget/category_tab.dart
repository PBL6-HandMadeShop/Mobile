import 'package:craftshop2/common/widgets/layouts/grid_layout.dart';
import 'package:craftshop2/common/widgets/products/product_cart/product_cart_vertical.dart';
import 'package:craftshop2/common/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';

import '../../../../../common/brand/brand_showcase.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/cs_home_product_controller.dart';
import '../../../models/model_category.dart';

class CsCategoryTab extends StatefulWidget {
  const CsCategoryTab({super.key});
  @override
  _CsCategoryTabState createState() => _CsCategoryTabState();

}
class _CsCategoryTabState extends State<CsCategoryTab> {
  late Future<List<Product>> _products;
  @override
  void initState() {
    super.initState();
    _products = ProductService().getProductsPage(0, 10);  // Lấy dữ liệu sản phẩm từ API
  }
  @override
  Widget build(BuildContext context) {
    return  ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(CSSize.defaultSpace),
          child: Column(
            children: [
              ///-- Brand
              const CSBrandShowCase(
                images: [
                  CSImage.product2,
                  CSImage.product2,
                  CSImage.product2,
                ],
              ), const CSBrandShowCase(
                images: [
                  CSImage.product2,
                  CSImage.product2,
                  CSImage.product2,
                ],
              ),
              const SizedBox(height: CSSize.spaceBtwItems,),
              ///-- Products
              CSSectionHeading(title: "You might like", showActionButton: true, onPressed: (){}),
              const SizedBox(height: CSSize.spaceBtwItems,),

              CSGridLayout(itemCount: 4, itemBuilder: (_, index) => const CSProductCardVertical()),
              const SizedBox(height: CSSize.spaceBtwSections,),
            ],
          ),
        ),
      ],
    );
  }
}
