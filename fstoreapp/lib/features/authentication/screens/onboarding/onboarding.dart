import 'package:flutter/material.dart';
import 'package:fstoreapp/features/authentication/controllers/onboarding_controller/onboarding_controller.dart';
import 'package:fstoreapp/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:fstoreapp/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:fstoreapp/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:fstoreapp/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/text_strings.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? Colors.black : Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnboardingPage(
                image: FImages.onBoardingImage1,
                title: FTexts.onBoardingTitle1,
                subTitle: FTexts.onBoardingSubTitle1,
              ),
              OnboardingPage(
                image: FImages.onBoardingImage2,
                title: FTexts.onBoardingTitle2,
                subTitle: FTexts.onBoardingSubTitle2,
              ),
              OnboardingPage(
                image: FImages.onBoardingImage3,
                title: FTexts.onBoardingTitle3,
                subTitle: FTexts.onBoardingSubTitle3,
              )
            ],
          ),

          /// Skip Button
          const OnboardingSkip(),

          /// Dot Navigation SmoothPageIndicator
          const OnboardingDotNavigation(),

          /// Circular Button
          const OnboardingNextButton()
        ],
      ),
    );
  }
}
