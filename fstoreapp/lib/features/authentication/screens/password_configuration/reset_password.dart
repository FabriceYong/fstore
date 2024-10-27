import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fstoreapp/features/authentication/controllers/reset_password_controller/reset_password_controller.dart';
import 'package:fstoreapp/features/authentication/screens/login/login.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/constants/text_strings.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(FSizes.defaultSpace),
            child: Column(
              children: [
                /// Image with 60% of screen width

                Image.asset(
                  FImages.deliveredEmailIllustration,
                  width: FHelperFunctions.screenWidth() * .6,
                ),
                const Gap(FSizes.spaceBtwSections),

                /// Email
                Text(
                  email,
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                const Gap(FSizes.spaceBtwItems),

                /// Title & SubTitle
                Text(
                  FTexts.changeYourPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const Gap(FSizes.spaceBtwItems),

                Text(
                  FTexts.changeYourPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const Gap(FSizes.spaceBtwSections),

                /// Buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => Get.offAll(() => const LoginScreen()),
                      child: const Text(FTexts.done)),
                ),
                const Gap(FSizes.spaceBtwItems),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () =>
                          controller.resendResetPasswordEmail(email),
                      child: const Text(FTexts.resendEmail)),
                )
              ],
            ),
          ),
        ));
  }
}
