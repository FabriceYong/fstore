import 'package:f_store_dashboard/features/authentication/controllers/forgot_password_controller.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/text_strings.dart';

class FResetPasswordWidget extends StatelessWidget {
  const FResetPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final email = Get.parameters['email'] ?? '';
    final ForgotPasswordController controller =
        Get.put(ForgotPasswordController());
    return Column(
      children: [
        /// HEADER
        Row(
          children: [
            IconButton(
                onPressed: () => Get.offAllNamed(FRoutes.login),
                icon: const Icon(CupertinoIcons.clear)),
          ],
        ),
        const Gap(FSizes.spaceBtwItems),

        /// IMAGE
        const Image(
          image: AssetImage(FImages.deliveredEmailIllustration),
          width: 300,
          height: 300,
        ),
        const Gap(FSizes.spaceBtwItems),

        /// TITLE AND SUBTITLE
        Text(
          FTexts.changeYourPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const Gap(FSizes.spaceBtwItems),
        Text(
          email,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const Gap(FSizes.spaceBtwItems),
        Text(
          FTexts.changeYourPasswordSubTitle,
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
        const Gap(FSizes.spaceBtwSections),

        /// BUTTONS
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: FColors.primary,
              padding: const EdgeInsets.symmetric(vertical: FSizes.lg * .75),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(FSizes.defaultSpace / 2),
              ),
            ),
            onPressed: () {
              Get.offAllNamed(FRoutes.login);
            },
            child: const Text(FTexts.done),
          ),
        ),
        const Gap(FSizes.spaceBtwItems),
        SizedBox(
          width: double.infinity,
          child: TextButton(
              onPressed: () =>
                  controller.resendPasswordResetEmail(email: email),
              child: const Text(FTexts.resendEmail)),
        ),
      ],
    );
  }
}
