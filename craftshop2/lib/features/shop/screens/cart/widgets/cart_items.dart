import 'package:flutter/material.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';

class CSCartItems extends StatelessWidget{
  const CSCartItems ({
    super.key,
    this.showAddRemoveButton = true,
});

  final bool showAddRemoveButton;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 2,
      separatorBuilder: (_, __) => const SizedBox(height: CSSize.spaceBtwSections),
      itemBuilder: (_, index) => Column(
        children: [
          ///CSCartItem(),
          if(showAddRemoveButton)
          const SizedBox(height: CSSize.spaceBtwItems,),

          if(showAddRemoveButton)
          const Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 70),
                  CSProductQuanityWithAddRemoveButton(),
                ],
              ),
              /// Add Remove Buttons

              CSProductPriceText(price: '256'),// Row
            ],
          ),

        ],
      ),
    ); // ListView.se
  }
}