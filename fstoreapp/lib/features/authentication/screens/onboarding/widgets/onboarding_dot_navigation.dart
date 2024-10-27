import 'package:flutter/material.dart';
import 'package:fstoreapp/features/authentication/controllers/onboarding_controller/onboarding_controller.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/device/device_utility.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingDotNavigation extends StatelessWidget {
  const OnboardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    final dark = FHelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: FDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: FSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: ExpandingDotsEffect(
            dotHeight: 6, activeDotColor: dark ? FColors.light : FColors.dark),
      ),
    );
  }
}
