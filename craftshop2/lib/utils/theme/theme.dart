import 'package:craftshop2/utils/theme/custom_themes/appbar_theme.dart';
import 'package:craftshop2/utils/theme/custom_themes/bottem_sheet_theme.dart';
import 'package:craftshop2/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:craftshop2/utils/theme/custom_themes/text_field_theme.dart';
import 'package:craftshop2/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

import 'custom_themes/check_box.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/outlined_button_theme.dart';

class CraftShopTheme {
  CraftShopTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: CSTextTheme.lightTextTheme,
    chipTheme: CSChipTheme.lightChipTheme,
    appBarTheme: CSAppbarTheme.lightAppbarTheme,
    checkboxTheme: CScheckBoxTheme.lightCheckBoxTheme,
    bottomSheetTheme: CSBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: CSElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: CSOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: CSTextFormTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: CSTextTheme.darkTextTheme,
    chipTheme: CSChipTheme.darkChipTheme,
    appBarTheme: CSAppbarTheme.dartlightAppbarTheme,
    checkboxTheme: CScheckBoxTheme.darkCheckBoxTheme,
    bottomSheetTheme: CSBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: CSElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: CSOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: CSTextFormTheme.darkInputDecorationTheme,

  );
}