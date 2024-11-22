import 'package:flutter/material.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/texts.dart';

class CSHomeAppBar extends StatelessWidget {
  const CSHomeAppBar({
    super.key, required this.Subtitle,
  });
  final String Subtitle;
  @override
  Widget build(BuildContext context) {
    return CSAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            CSText.homeAppbarTitle,
            style: Theme.of(context).textTheme.labelMedium!.apply(color: CSColors.grey),
          ),
          Text(
            Subtitle,
            style: Theme.of(context).textTheme.headlineSmall!.apply(color: CSColors.white),
          ),
        ],
      ),
      actions: [
        CSCartCounterIcon(
          onPressed: () {},
          iconColor: CSColors.white,
        ),
      ],
    );
  }
}