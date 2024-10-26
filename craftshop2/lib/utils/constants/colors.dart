import 'package:flutter/material.dart';

class CSColors {
  CSColors._();
// APP BASIC COLORS
  static const Color primaryColor = Color(0xFF4B68FF);
  static const Color secondaryColor = Color(0xFFFFE24B);
  static const Color accentColor = Color(0xFFB0C7FF);
  //TEXT COLORS
  static const Color textPrimaryColor = Color(0xFF333333);
  static const Color textSecondaryColor = Color(0xFF6C757D);
  static const Color textWhiteColor = Colors.white;
  //background colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackgound = Color(0xFFF3F5FF);
  // gradient colors
  static const Gradient linerGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707,-0.707),
    colors: [Color(0xffff9a9e), Color(0xfffad0c4), Color(0xfffad0c4)],
  );
  // background container colors
  static const Color lightContainer = Color(0xfff6f6f6);
  static  Color darkContainer = CSColors.white.withOpacity(0.1);

  //button colors
  static const Color buttonPrimaryColor = Color(0xFF4B68FF);
  static const Color buttonSecondaryColor = Color(0xFF6c757d);
  static const Color buttonDisabledColor = Color(0xFFc4c4c4);

  // border colors
  static const Color borderPrimaryColor = Color(0xFFD9d9d9);
  static const Color borderSecondaryColor = Color(0xFFE6E6E6);

  // error and validation colors
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFf57c00);
  static const Color infoColor = Color(0xFF1976D2);

  //neutral colors
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff232323);
  static const Color darkerGrey = Color(0xff4f4f4f);
  static const Color darkgrey = Color(0xff939393);
  static const Color grey = Color(0xffe0e0e0);
  static const Color lightGrey = Color(0xfff9f9f9);
  static const Color softGrey = Color(0xfff4f4f4);
}