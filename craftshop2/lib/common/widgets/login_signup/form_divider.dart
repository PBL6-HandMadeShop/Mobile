import 'package:craftshop2/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';

class CSFormDivider extends StatelessWidget {
  const CSFormDivider({
    super.key,
    required this.dividerText,
    required this.dark,
  });

  final bool dark;
  final String dividerText ;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Divider(color: dark ? CSColors.darkgrey : CSColors.grey, thickness:  0.5, indent: 60, endIndent: 5 ,)),
        Text(CSText.orSignInWith.capitalize!, style: Theme.of(context).textTheme.labelMedium,),
        Flexible(child: Divider(color: dark ? CSColors.darkgrey : CSColors.grey, thickness:  0.5, indent: 60, endIndent: 5 ,))
      ],
    );
  }
}