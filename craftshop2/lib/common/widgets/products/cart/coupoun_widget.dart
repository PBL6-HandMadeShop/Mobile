import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../custom_shape/containers/rounded_container.dart';

class CSCouponCode extends StatelessWidget {
  const CSCouponCode({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return CSRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? CSColors.dark : CSColors.white,
      padding: const EdgeInsets.only(
        top: CSSize.sm,
        bottom: CSSize.sm,
        right: CSSize.sm,
        left: CSSize.sm,
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have a promo code? Enter here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ), // InputDecoration
            ), // TextFormField
          ), // Flexible

          /// Button
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: dark ? CSColors.white.withOpacity(0.5) : CSColors.dark.withOpacity(0.5),
                backgroundColor: Colors.grey.withOpacity(0.2),
                side: BorderSide(color: Colors.grey.withOpacity(0.1)),
              ),
              child: const Text('Apply'),
            ), // ElevatedButton
          ), // SizedBox

        ],
      ), // TRoundedContainer
    );
  }
}