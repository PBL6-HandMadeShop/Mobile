import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shape/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class CSOrderListItems extends StatelessWidget {
  const CSOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (_,__) => const SizedBox(height: CSSize.spaceBtwItems,),
      itemBuilder: (_, index) => CSRoundedContainer(
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
                        'Processing',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(color: CSColors.primaryColor, fontWeightDelta: 1),
                      ), // Text
                      Text('07 Nov 2024', style: Theme.of(context).textTheme.headlineSmall),
                    ], // Column children
                  ),
                ), 
                
                /// 3 - Icon
                IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_34, size: CSSize.iconSm,))
              ],
            ),
            const SizedBox(height: CSSize.spaceBtwItems,),
      
            ///row 2
            Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    // 1 - Icon
                    const Icon(Iconsax.tag),
                    const SizedBox(width: CSSize.spaceBtwItems / 2),
                
                    // 2 - Status & Date
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order', style: Theme.of(context).textTheme.labelMedium),
                          Text('[#256f2]', style: Theme.of(context).textTheme.titleMedium),
                        ], // Column children
                      ), // Column
                    ), // Expanded
                  ], // Row children
                ),
              ), // Row
      
              Expanded(
                child: Row(
                  children: [
                    // 1 - Icon
                    const Icon(Iconsax.calendar),
                    const SizedBox(width: CSSize.spaceBtwItems / 2),
                
                    // 2 - Status & Date
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Shipping Date', style: Theme.of(context).textTheme.labelMedium),
                          Text('03 Feb 2025', style: Theme.of(context).textTheme.titleMedium),
                        ], // Column children
                      ), // Column
                    ), // Expanded
                  ], // Row children
                ),
              ), // Row
            ],
            ),
      
          ], // Column children
        ), // Column
      ),
    ); // TRoundedContainer
  }
}
