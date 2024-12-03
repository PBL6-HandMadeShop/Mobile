import 'package:HandcraftShop/src/common_widget/form/form_header_widget.dart';
import 'package:HandcraftShop/src/constants/colors.dart';
import 'package:HandcraftShop/src/constants/image_string.dart';
import 'package:HandcraftShop/src/constants/size.dart';
import 'package:HandcraftShop/src/constants/text_string.dart';
import 'package:HandcraftShop/src/feature/authentication/screen/signup/sign_up_form_widget.dart';

import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: primaryColor,
          body: SingleChildScrollView(
              child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              children: [
                const FormHeaderWidget(
                    image: logoImage,
                    title: registerTitle,
                    subTile: registerSubtitle),
                SignUpFormWidget(),
                Column(
                  children: [
                    const Text("Or"),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(),
                            side: BorderSide(color: secondaryColor, width: 2),
                          ),
                          icon: Image(
                            image: AssetImage(googleImage),
                            width: 20,
                          ),
                          onPressed: () {},
                          label: Text("Sign-in With Google",
                              style: TextStyle(fontSize: 15))),
                    ),
                    const SizedBox(height: defaultSize - 30),
                    TextButton(
                        onPressed: () {},
                        child: Text.rich(TextSpan(
                          text: registerAlreadyHaveAnAccount,
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: const [
                            TextSpan(
                                text: registerLogin,
                                style: TextStyle(color: Colors.blue))
                          ],
                        )))
                  ],
                )
              ],
            ),
          ))),
    );
  }
}
