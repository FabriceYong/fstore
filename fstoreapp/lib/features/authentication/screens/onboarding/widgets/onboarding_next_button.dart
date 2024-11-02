import 'package:flutter/material.dart';
import 'package:fstoreapp/features/authentication/controllers/onboarding_controller/onboarding_controller.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/device/device_utility.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    return Positioned(
      right: FSizes.defaultSpace,
      bottom: FDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: dark ? FColors.primary : FColors.black),
        onPressed: () => OnboardingController.instance.nextPage(),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}
