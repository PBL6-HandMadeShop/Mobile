import 'package:HandcraftShop/src/constants/image_string.dart';
import 'package:HandcraftShop/src/constants/size.dart';
import 'package:HandcraftShop/src/constants/text_string.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import 'login_footer_widget.dart';
import 'login_form_widget.dart';
import 'login_header_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(defaultSize),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              LoginHeaderWidget(size: size),
              const LoginForm(),
              LoginFooterWidget()
            ]),
          ),
        ),
      ),
    );
  }
}

