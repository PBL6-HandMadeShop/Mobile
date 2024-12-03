import 'package:craftshop2/features/personalization/models/delivery_infor.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_shape/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class CSSingleAddress extends StatelessWidget {
  final DeliveryInfo info;
  final bool selectedAddress;

  const CSSingleAddress({
    super.key,
    required this.info,
    this.selectedAddress = false,
  });

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return CSRoundedContainer(
      width: double.infinity,
      showBorder: true,
      padding: const EdgeInsets.all(CSSize.md),
      backgroundColor: selectedAddress
          ? CSColors.primaryColor.withOpacity(0.5)
          : Colors.transparent,
      borderColor: selectedAddress
          ? Colors.transparent
          : dark
              ? CSColors.darkerGrey
              : CSColors.grey,
      margin: const EdgeInsets.only(bottom: CSSize.spaceBtwItems),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            info.address,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge,
            softWrap: true,
          ),
          const SizedBox(height: CSSize.sm / 2),
          Text(
            '${info.ward}, ${info.district}, ${info.city}, ${info.province}',
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
