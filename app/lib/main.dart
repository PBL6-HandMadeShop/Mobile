import 'package:HandcraftShop/src/feature/authentication/screen/onboarding_screen/onboarding_screen.dart';
import 'package:HandcraftShop/src/feature/authentication/screen/splash_screen/splash_screen.dart';
import 'package:HandcraftShop/src/feature/authentication/screen/welcome_screen/welcome_screen.dart';
import 'package:HandcraftShop/src/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: TAppTheme.lightTheme,
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      home: const OnboardingScreen(),
    );
  }
}


