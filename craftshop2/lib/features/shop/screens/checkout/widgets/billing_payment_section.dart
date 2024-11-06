import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_shape/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class CSBillingPaymentSection extends StatelessWidget {
  const CSBillingPaymentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        CSSectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () {},
        ),
        const SizedBox(height: CSSize.spaceBtwItems / 2),
        Row(
          children: [
            CSRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? CSColors.light : CSColors.white,
              padding: const EdgeInsets.all(CSSize.sm),
              child: const Image(
                image: AssetImage(CSImage.painting),
                fit: BoxFit.contain,
              ), // TRoundedContainer
            ),
            const SizedBox(width: CSSize.spaceBtwItems / 2),
            Text('Paypal', style: Theme.of(context).textTheme.bodyLarge),
          ], // Row children
        ), // Row
      ], // Column children
    ); // Column
  }
}
