import 'package:flutter/material.dart';

import '../../../utils/constants/enums.dart';

class CSBrandTitleText extends StatelessWidget {
  const CSBrandTitleText({
    super.key,
    this.color,
    required this.title,
     this.maxLines = 2,
    this.textAlign = TextAlign.left,
    this.brandTextSize = TextSizes.small,
  });
  final Color? color;
  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      // check which brandSize is required and set that style
      style: brandTextSize == TextSizes.small
              ?Theme.of(context).textTheme.labelMedium!.apply(color: color)
              :brandTextSize == TextSizes.large
                ?Theme.of(context).textTheme.titleLarge!.apply(color: color)
                :Theme.of(context).textTheme.headlineMedium!.apply(color: color),
    );
  }
}