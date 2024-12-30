import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/sortable/sortable_products.dart';
import '../../../../utils/constants/sizes.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key, required this.productPagePopular});
  final List<dynamic>? productPagePopular;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar
        appBar: const CSAppBar(title: Text('Popular Products'), showBackArrow: true),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(CSSize.defaultSpace),
              child: CSSortableProducts(productPagePopular: productPagePopular,), // Column
    ), // Padding
    ),
    );
  }
}
