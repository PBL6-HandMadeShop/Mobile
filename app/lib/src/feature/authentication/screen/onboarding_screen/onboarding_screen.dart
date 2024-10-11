import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../welcome_screen/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Get.to(() => const WelcomeScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(child: RiveAnimation.asset("asset/RiveAssets/validation.riv"),
        ),
        Positioned(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: SizedBox()),
        ),
        SafeArea(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(children:[
            SizedBox(
              width: 300,
              child: Column(
                children: [
                  Text("It's \nShopping Time",style: TextStyle(
                    fontSize: 60,
                    fontFamily: "Poppins",
                    height: 1.2,
                  ),),
                  SizedBox(height: 16),
                  Text("Get your hands on the best handcrafted items from the best artisans in the world",),

                ],
              ),
            )
          ]),
        ))
      ]),
    );
  }
}
