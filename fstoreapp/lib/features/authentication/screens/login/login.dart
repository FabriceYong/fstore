import 'package:flutter/material.dart';
import 'package:fstoreapp/common/styles/spacing_styles.dart';
import 'package:fstoreapp/common/widgets/dividers/divider.dart';
import 'package:fstoreapp/common/widgets/login_signup/social_buttons.dart';
import 'package:fstoreapp/features/authentication/screens/login/widgets/login_form.dart';
import 'package:fstoreapp/features/authentication/screens/login/widgets/login_header.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/constants/text_strings.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: FSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ///Header
              FLoginHeader(),

              /// Form
              FLoginForm(),

              /// Divider
              FDivider(
                dividerText: FTexts.orSignInWith,
              ),
              Gap(FSizes.spaceBtwSections),

              /// Footer
              FSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
