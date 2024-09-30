import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/size.dart';
import '../../../../constants/text_string.dart';
import '../forget_password/forget_password_mail/forget_password_mail.dart';
import '../forget_password/forget_password_options/forget_password_btn_widget.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: defaultSize - 10),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: defaultSize - 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.fingerprint),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility_off),
                    onPressed: null,
                  ),
                ),
              ),
              const SizedBox(height: defaultSize - 20),
              // FORGET PASSWORD BTN
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          builder: (content) =>
                              Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(defaultSize),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(forgotPasswordTitle,
                                          style: Theme
                                              .of(content)
                                              .textTheme
                                              .headlineMedium),
                                      Text(forgotPasswordSubtitle,
                                          style: Theme
                                              .of(content)
                                              .textTheme
                                              .bodyMedium),
                                      const SizedBox(height: 30),
                                      ForgetPasswordBtnWidget( // E-MAIL
                                        btnIcon: Icons.mail_outline_rounded,
                                        title: 'E-mail',
                                        subtitle: resetViaEmail,
                                        onTap: () {
                                          Navigator.pop(context);
                                          Get.to(const ForgetPasswordMailScreen());},
                                      ),
                                      const SizedBox(height: 20),
                                      ForgetPasswordBtnWidget( // PHONE
                                        btnIcon: Icons.phone_callback_outlined,
                                        title: 'Phone number',
                                        subtitle: resetViaPhone,
                                        onTap: () {},
                                      ),

                                    ]),
                              ),
                        );
                      },
                      child: Text(loginForgotPassword))),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(loginButton.toUpperCase()),
                    style: OutlinedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(),
                        foregroundColor: whiteColor,
                        backgroundColor: secondaryColor,
                        side: BorderSide(color: secondaryColor),
                        padding: EdgeInsets.symmetric(vertical: buttonHeight)),
                  )),
            ])));
  }
}

