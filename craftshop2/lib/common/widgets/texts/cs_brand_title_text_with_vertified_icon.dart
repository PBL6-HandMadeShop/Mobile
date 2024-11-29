import 'package:craftshop2/common/widgets/texts/cs_brand_title_text.dart';
import 'package:craftshop2/utils/constants/enums.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CsBrandTitleTextWithVertifiedIcon extends StatelessWidget {
  const CsBrandTitleTextWithVertifiedIcon(
      {super.key,
      required this.title,
      this.maxLines = 1,
      this.textColor,
      this.iconColor = CSColors.primaryColor,
      this.textAlign = TextAlign.center,
      this.brandTextSize = TextSizes.small});

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            child: CSBrandTitleText(
                title: title,
                maxLines: maxLines,
                color: textColor,
                textAlign: textAlign,
                brandTextSize: brandTextSize)),
        const SizedBox(
          width: CSSize.xs,
        ),
        // Icon(
        //   Iconsax.verify5,
        //   color: iconColor,
        //   size: CSSize.iconXs,
        // )
      ],
    );
  }
}
