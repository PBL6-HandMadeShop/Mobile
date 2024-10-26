import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CSCircularlIcon extends StatelessWidget {
  const CSCircularlIcon({
    super.key,
    required this.dark,
    this.width,
    this.height,
    this.size = CSSize.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });

  final bool dark;
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
            : dark
            ? CSColors.dark.withOpacity(0.9)
            : CSColors.white.withOpacity(0.9),
      ),
      child: IconButton(onPressed: onPressed, icon: Icon(icon, color: color, size: size,)),
    );
  }
}
