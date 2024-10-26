import 'package:craftshop2/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class CSRoundedContainer extends StatelessWidget {
  const CSRoundedContainer({

    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.showBorder =false,
    this.radius = CSSize.cardRadiusLg,
    this.borderColor = CSColors.white,
    this.backgroundColor = CSColors.borderPrimaryColor,

  });

  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;




  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}