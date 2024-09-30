import 'package:HandcraftShop/src/utils/theme/widget_theme/text_field.theme.dart';
import 'package:HandcraftShop/src/utils/theme/widget_theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TAppTheme{
  TAppTheme._();
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
    inputDecorationTheme: TextFieldTheme.lightTextFieldTheme,

  );
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
    inputDecorationTheme: TextFieldTheme.dartkTextFieldTheme,
  );
  static ThemeMode themeMode = ThemeMode.system;

}