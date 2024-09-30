import 'package:HandcraftShop/src/constants/colors.dart';
import 'package:flutter/material.dart';

class TextFieldTheme {
  TextFieldTheme._();

  static InputDecorationTheme lightTextFieldTheme = const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: secondaryColor,
    floatingLabelStyle: TextStyle(color: secondaryColor),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 5, color: secondaryColor),
    ),
  );
  static InputDecorationTheme dartkTextFieldTheme = const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: primaryColor,
    floatingLabelStyle: TextStyle(color: primaryColor),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 5, color: primaryColor),
    ),
  );
}
