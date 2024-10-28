import 'package:craftshop2/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_string.dart';
import '../../controllers/onboarding/onboarding_controller.dart';
import 'OnBoardingDotNavigation.dart';
import 'OnBoardingPage.dart';
import 'OnboardingNextButton.dart';
import 'OnboardingSkip.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          /// Horizontal Scrolltable View
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              /// Onboarding Page 1
              OnBoardingPage(
                  image: CSImage.onboarding1,
                  title: CSText.onboardingTitle1,
                  subtitle: CSText.onboardingSubtitle1),

              /// Onboarding Page 2
              OnBoardingPage(
                  image: CSImage.onboarding2,
                  title: CSText.onboardingTitle2,
                  subtitle: CSText.onboardingSubtitle2),

              /// Onboarding Page 3
              OnBoardingPage(
                  image: CSImage.onboarding3,
                  title: CSText.onboardingTitle3,
                  subtitle: CSText.onboardingSubtitle3),
            ],
          ),

          /// Skip Button
          const OnBoardingSkip(),

          /// Dot Navigation Smooth Page Indicator
          const OnboardingDotNavigation(),

          /// circular button
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}


