import 'package:flutter/material.dart';

import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/texts.dart';
import '../../../../utils/helpers/helper_functions.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    this.image = CSImage.onboarding1,
    this.title = CSText.onboardingTitle1,
    this.subtitle = CSText.onboardingSubtitle1,
    super.key,
  });

  final String image, title, subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(CSSize.defaultSpace),
      child: Column(
        children: [
          Image(
              width: CSHelperFunctions.screenWidth() * 0.8,
              height: CSHelperFunctions.screenHeight() * 0.6,
              image: AssetImage(image)),
          Text(title, style: Theme
              .of(context)
              .textTheme
              .headlineMedium, textAlign: TextAlign.center,),
          const SizedBox(height: CSSize.spaceBtwItems,),
          Text(subtitle, style: Theme
              .of(context)
              .textTheme
              .bodyMedium, textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}