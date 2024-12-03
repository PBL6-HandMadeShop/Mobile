import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shape/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class CSOrderListItems extends StatelessWidget {
  final Map<String, dynamic> order; // Thay vì danh sách, nhận một đơn hàng

  const CSOrderListItems({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);

    return CSRoundedContainer(
      showBorder: true,
      padding: const EdgeInsets.all(CSSize.md),
      backgroundColor: dark ? CSColors.dark : CSColors.light,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// -- Row 1
          Row(
            children: [
              /// 1 - Icon
              const Icon(Iconsax.ship),
              const SizedBox(width: CSSize.spaceBtwItems / 2),

              /// 2 - Status & Date
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['status'] ?? 'Unknown',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: CSColors.primaryColor, fontWeightDelta: 1),
                    ),
                    Text(
                      order['createdAt'] ?? 'No Date',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),

              /// 3 - Icon
              IconButton(
                onPressed: () {
                  // Điều hướng đến chi tiết đơn hàng nếu cần
                },
                icon: const Icon(Iconsax.arrow_right_34, size: CSSize.iconSm),
              )
            ],
          ),
          const SizedBox(height: CSSize.spaceBtwItems),

          /// -- Row 2
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    // 1 - Icon
                    const Icon(Iconsax.tag),
                    const SizedBox(width: CSSize.spaceBtwItems / 2),

                    // 2 - Order Info
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order', style: Theme.of(context).textTheme.labelMedium),
                          Text('[#${order['id']}]', style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    // 1 - Icon
                    const Icon(Iconsax.calendar),
                    const SizedBox(width: CSSize.spaceBtwItems / 2),

                    // 2 - Shipping Info
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Shipping Date', style: Theme.of(context).textTheme.labelMedium),
                          Text(
                            order['shipmentInfo']?['shipmentStatus'] ?? 'No Info',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
