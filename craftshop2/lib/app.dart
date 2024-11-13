import 'package:craftshop2/features/authencation/screens/onboarding/onboarding.dart';
import 'package:craftshop2/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'biindings/general_bindings.dart';
 ///-----Use this class to setup themes, initial Bindings, any animations and
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: CraftShopTheme.lightTheme,
      darkTheme:  CraftShopTheme.darkTheme,
      home: const OnboardingScreen(),
    );
  }
}
