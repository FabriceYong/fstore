import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/dividers/divider.dart';
import 'package:fstoreapp/common/widgets/login_signup/social_buttons.dart';
import 'package:fstoreapp/features/authentication/screens/login/login.dart';
import 'package:fstoreapp/features/authentication/screens/register/widgets/register_form.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/constants/text_strings.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(FTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const Gap(FSizes.spaceBtwSections),

              /// Register Form
              const FRegisterForm(),
              const Gap(FSizes.spaceBtwItems),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Already registered',
                      style: Theme.of(context).textTheme.bodySmall),
                  const Gap(FSizes.xs),
                  InkWell(
                      onTap: () => Get.off(() => const LoginScreen()),
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.bodySmall!.apply(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? FColors.white
                                    : FColors.primary,
                            decoration: TextDecoration.underline),
                      ))
                ],
              ),
              const Gap(FSizes.spaceBtwSections),

              /// Divider
              const FDivider(dividerText: FTexts.orSignUpWith),
              const Gap(FSizes.spaceBtwSections),

              /// Social Buttons
              const FSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
