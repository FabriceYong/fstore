import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fstoreapp/data/repositories/authentication/authentication_repository.dart';
import 'package:fstoreapp/features/authentication/controllers/verify_email_controller/verify_email_controller.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/constants/text_strings.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});
  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => AuthenticationRepository.instance.logout(),
            icon: const Icon(CupertinoIcons.clear),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(FSizes.defaultSpace),
        child: Column(
          children: [
            /// Image
            Image.asset(
              FImages.deliveredEmailIllustration,
              width: FHelperFunctions.screenWidth() * .6,
            ),
            const Gap(FSizes.spaceBtwSections),

            /// Title & SubTitle
            Text(
              FTexts.confirmEmail,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const Gap(FSizes.spaceBtwItems),
            Text(
              email ?? '',
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            const Gap(FSizes.spaceBtwItems),
            Text(
              FTexts.confirmEmailSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const Gap(FSizes.spaceBtwSections),

            /// Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.checkEmailVerificationStatus(),
                  child: const Text(FTexts.tContinue)),
            ),
            const Gap(FSizes.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: () => controller.sendEmailVerification(),
                  child: const Text(FTexts.resendEmail)),
            )
          ],
        ),
      )),
    );
  }
}
