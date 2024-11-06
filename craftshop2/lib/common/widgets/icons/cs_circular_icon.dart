import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CSCircularlIcon extends StatelessWidget {
  const CSCircularlIcon({
    super.key,
    this.width,
    this.height,
    this.size = CSSize.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });
  
  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor != null
            ? backgroundColor!
            : CSHelperFunctions.isDarkMode(context)
              ? CSColors.dark.withOpacity(0.9)
              : CSColors.white.withOpacity(0.9),
      ),
      child: IconButton(onPressed: onPressed, icon: Icon(icon, color: color, size: size,)),
    );
  }
}
