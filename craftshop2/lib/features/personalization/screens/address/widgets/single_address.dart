import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shape/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class CSSingleAddress extends StatelessWidget{
  const CSSingleAddress({
    super.key,
    required this.selectedAddress,
});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return CSRoundedContainer(
      width: double.infinity,
      showBorder: true,
      padding : const EdgeInsets.all(CSSize.md),
      backgroundColor: selectedAddress ? CSColors.primaryColor.withOpacity(0.5) : Colors.transparent,
      borderColor: selectedAddress
          ? Colors.transparent
          : dark
          ? CSColors.darkerGrey
          : CSColors.grey,
      margin: const EdgeInsets.only(bottom: CSSize.spaceBtwItems),
        child: Stack(
          children: [
            Positioned(
              right: 5,
              top: 0,
              child: Icon(
                selectedAddress ? Iconsax.tick_circle5 : null,
                color: selectedAddress
                    ? dark
                      ? CSColors.light
                      : CSColors.dark
                    : null,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ), // Text
                const SizedBox(height: CSSize.sm / 2),
                const Text(
                  '(+123) 456 7890',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: CSSize.sm / 2),
                const Text(
                  '82356 Timmy Coves, South Liana, Maine, 87665, USA',
                  softWrap: true,
                ),
              ], // Column
            ),
          ],
        ),
    );
  }

}