import 'package:flutter/material.dart';
import 'package:fstoreapp/features/authentication/controllers/federated_identity_logins/google_sign_controller.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FSocialButtons extends StatelessWidget {
  const FSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GoogleSignController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: FColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () => controller.googleAuth(),
            icon: Image.asset(
              FImages.google,
              height: FSizes.iconMd,
              width: FSizes.iconMd,
            ),
          ),
        ),
        const Gap(FSizes.spaceBtwSections),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: FColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () => controller.signInWithFacebook(),
            icon: Image.asset(
              FImages.facebook,
              height: FSizes.iconMd,
              width: FSizes.iconMd,
            ),
          ),
        ),
      ],
    );
  }
}
