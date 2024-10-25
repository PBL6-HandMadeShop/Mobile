import 'package:flutter/cupertino.dart';

import '../../utils/constants/sizes.dart';

class CSSpacinngStyle{
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: CSSize.appbarHeight,
    left: CSSize.defaultSpace,
    right: CSSize.defaultSpace,
    bottom: CSSize.defaultSpace,
  );
}