import 'package:flutter/material.dart';
import 'package:fstoreapp/features/authentication/controllers/signup_controller/signup_controller.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/constants/text_strings.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FTermsAndConditionsCheckbox extends StatelessWidget {
  const FTermsAndConditionsCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    final controller = Get.put(SignupController());
    return Row(
      children: [
        Obx(
          () => SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value =
                  !controller.privacyPolicy.value,
            ),
          ),
        ),
        const Gap(FSizes.sm),
        Text.rich(
          TextSpan(
            text: '${FTexts.iAgreeTo} ',
            style: Theme.of(context).textTheme.bodySmall,
            children: [
              TextSpan(
                  text: '${FTexts.privacyPolicy} ',
                  style: Theme.of(context).textTheme.bodySmall!.apply(
                      decoration: TextDecoration.underline,
                      color: dark ? FColors.white : FColors.primary)),
              TextSpan(
                  text: '${FTexts.and} ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                  text: '${FTexts.termsOfUse} ',
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                      decoration: TextDecoration.underline,
                      color: dark ? FColors.white : FColors.primary))
            ],
          ),
        ),
      ],
    );
  }
}
