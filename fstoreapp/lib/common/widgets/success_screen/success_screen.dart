import 'package:flutter/material.dart';
import 'package:fstoreapp/common/styles/spacing_styles.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/constants/text_strings.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: FSpacingStyles.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              /// Image
              Lottie.asset(
                image,
                width: FHelperFunctions.screenWidth() * .6,
              ),
              const Gap(FSizes.spaceBtwSections),

              /// Title & SubTitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const Gap(FSizes.spaceBtwItems),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const Gap(FSizes.spaceBtwSections),

              /// Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(FTexts.tContinue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
