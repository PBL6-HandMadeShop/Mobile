import 'package:craftshop2/app.dart';
import 'package:craftshop2/utils/constants/colors.dart';
import 'package:craftshop2/utils/constants/sizes.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/texts.dart';
import 'widget/login_form.dart';
import 'widget/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: CSSpacinngStyle.paddingWithAppBarHeight,
        child: Column(
          children: [
            /// Login, title subtitle
            CSLoginHeader(dark: dark),
            const CSLoginform(),
            /// Drivider
            CSFormDivider(dividerText: CSText.orSignInWith, dark: dark),
            const SizedBox(height: CSSize.spaceBtwSections,),
            /// Footer
            CSSocialButtons()
          ],
        )
          ///
        ),
    );
  }
}






