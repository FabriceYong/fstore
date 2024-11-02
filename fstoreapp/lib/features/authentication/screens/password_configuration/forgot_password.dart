import 'package:flutter/material.dart';
import 'package:fstoreapp/features/authentication/controllers/reset_password_controller/reset_password_controller.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/constants/text_strings.dart';
import 'package:fstoreapp/utils/validators/validation.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(FSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(
              FTexts.forgetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(FSizes.spaceBtwItems),
            const Text(FTexts.forgetPasswordSubTitle),
            const Gap(FSizes.spaceBtwSections * 2),

            /// Text Fields
            Form(
              key: controller.resetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: (email) => FValidator.validateEmail(email),
                decoration: const InputDecoration(
                  labelText: FTexts.email,
                  prefixIcon: Icon(Iconsax.direct_right),
                ),
              ),
            ),
            const Gap(FSizes.spaceBtwSections),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.resetPassword(),
                child: const Text(FTexts.submit),
              ),
            )
          ],
        ),
      ),
    );
  }
}
