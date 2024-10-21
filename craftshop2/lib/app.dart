import 'package:craftshop2/utils/theme/theme.dart';
import 'package:flutter/material.dart';
 ///-----Use this class to setup themes, initial Bindings, any animations and
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: CraftShopTheme.lightTheme,
      darkTheme:  CraftShopTheme.darkTheme,
    );
  }
}
