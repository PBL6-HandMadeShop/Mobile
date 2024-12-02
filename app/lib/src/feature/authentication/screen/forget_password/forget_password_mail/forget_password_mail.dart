import 'package:HandcraftShop/src/common_widget/form/form_header_widget.dart';
import 'package:HandcraftShop/src/constants/size.dart';
import 'package:HandcraftShop/src/feature/authentication/screen/forget_password/forget_password_otp/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/image_string.dart';
import '../../../../../constants/text_string.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              children: [
                const SizedBox(
                  height: defaultSize * 4,
                ),
                const FormHeaderWidget(
                  image: passwordImg,
                  title: forgotPassword,
                  subTile: forgotPasswordSubtitle,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBetween: 20,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: formHeight),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: "Enter your email",
                        hintStyle: TextStyle(fontSize: 15),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(()=> const OTPScreen());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(fontSize: 20),
                            shape: RoundedRectangleBorder(),
                          ),
                          child: Text("NEXT"),
                        )),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
