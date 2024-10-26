import 'package:craftshop2/features/authencation/controllers/onboarding/onboarding_controller.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';

class OnboardingDotNavigation extends StatelessWidget {
   const OnboardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    final controller = OnboardingController.instance;
    return Positioned(bottom: CSDeviceUtils.getBottomNavigationBarHeight() + 25,
        left: CSSize.defaultSpace,

        child: SmoothPageIndicator(
            controller: controller.pageController,
            onDotClicked: controller.dotNavigationClick,
            count: 3,
            effect: ExpandingDotsEffect(
                activeDotColor:dark ?CSColors.light: CSColors.dark, dotHeight: 6)));
  }
}