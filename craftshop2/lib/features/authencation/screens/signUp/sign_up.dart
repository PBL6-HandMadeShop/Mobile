import 'package:craftshop2/common/widgets/login_signup/form_divider.dart';
import 'package:craftshop2/common/widgets/login_signup/social_buttons.dart';
import 'package:craftshop2/features/authencation/screens/signUp/widgets/sign_up_form.dart';
import 'package:craftshop2/utils/constants/colors.dart';
import 'package:craftshop2/utils/constants/sizes.dart';
import 'package:craftshop2/utils/constants/texts.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(CSSize.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///title
                Text(
                  CSText.SignUpTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: CSSize.spaceBtwSections,
                ),

                ///form
                CSSignupForm(dark: dark),

                /// Divider
                const SizedBox(
                  height: CSSize.spaceBtwSections,
                ),
                CSFormDivider(
                  dark: dark,
                  dividerText: CSText.orSignUpWith,
                ),
                const SizedBox(
                  height: CSSize.spaceBtwSections,
                ),
                const CSSocialButtons(),
              ],
            )),
      ),
    );
  }
}

