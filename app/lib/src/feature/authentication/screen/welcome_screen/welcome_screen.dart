import 'package:HandcraftShop/src/constants/colors.dart';
import 'package:HandcraftShop/src/constants/image_string.dart';
import 'package:HandcraftShop/src/constants/size.dart';
import 'package:HandcraftShop/src/constants/text_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_core/src/get_main.dart';


import '../login/login_screen.dart';
import '../signup/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF2EED5),
      body: Container(
        padding: EdgeInsets.all(defaultSize),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Image(
            image: AssetImage(welcomeImage),
            height: height * 0.6,
          ),
          Column(children: [
            Text(
              welcomeTitle,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                  fontSize: 30.0),
              textAlign: TextAlign.center,
            ),
            Text(
              welcomeSubtitle,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                  fontSize: 15.0
              ),
            )
          ]),
          Row(children: [
            Expanded(
                child: OutlinedButton(
                    onPressed: () => Get.to(() => const LoginScreen()),
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        foregroundColor: secondaryColor,
                        side: BorderSide(color: secondaryColor),
                        padding: EdgeInsets.symmetric(vertical: buttonHeight)),
                    child: Text(loginButton.toUpperCase()))),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: ElevatedButton(
                    onPressed: () => Get.to(() => const SignUpScreen()),
                    style: OutlinedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(),
                        foregroundColor: whiteColor,
                        backgroundColor: secondaryColor,
                        side: BorderSide(color: secondaryColor),
                        padding: EdgeInsets.symmetric(vertical: buttonHeight)),
                    child: Text("Sign up ".toUpperCase()))),
          ])
        ]),
      ),
    );
  }
}
