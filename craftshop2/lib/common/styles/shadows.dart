import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class CSShadowStyle{
  static final verticalProductShadow = BoxShadow(
    color: CSColors.grey.withOpacity(0.1),
    spreadRadius: 7,
    blurRadius: 50,
    offset: const Offset(0, 2),
  );
  static final horizontalProductShadow = BoxShadow(
    color: CSColors.darkgrey.withOpacity(0.1),
    spreadRadius: 7,
    blurRadius: 50,
    offset: const Offset(0, 2),
  );
}