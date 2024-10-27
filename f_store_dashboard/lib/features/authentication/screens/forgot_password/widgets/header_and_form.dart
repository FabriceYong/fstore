import 'package:f_store_dashboard/features/authentication/controllers/forgot_password_controller.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/constants/text_strings.dart';
import 'package:f_store_dashboard/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FHeaderAndForm extends StatelessWidget {
  const FHeaderAndForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // HEADER
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Iconsax.arrow_circle_left,
            size: FSizes.defaultSpace,
          ),
        ),
        const Gap(FSizes.spaceBtwItems),
        Text(
          FTexts.forgotPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Gap(FSizes.spaceBtwItems),
        Text(
          FTexts.forgotPasswordSubTitle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const Gap(FSizes.spaceBtwSections),

        // FORM
        Form(
          key: controller.forgotPasswordKey,
          child: TextFormField(
            controller: controller.email,
            validator: (value) => FValidator.validateEmail(value),
            decoration: const InputDecoration(
              labelText: FTexts.email,
              prefixIcon: Icon(Iconsax.direct_right),
            ),
          ),
        ),
        const Gap(FSizes.spaceBtwSections),

        /// SUBMIT BUTTON
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
            onPressed: () => controller.sendPasswordResetEmail(),
            child: const Text(FTexts.submit),
          ),
        ),

        const Gap(FSizes.defaultSpace * 2),
      ],
    );
  }
}
