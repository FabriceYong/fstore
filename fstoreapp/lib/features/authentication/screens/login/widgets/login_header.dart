import 'package:flutter/material.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/constants/text_strings.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';

class FLoginHeader extends StatelessWidget {
  const FLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          dark ? FImages.lightAppLogo : FImages.darkAppLogo,
          height: 150,
        ),
        Text(
          FTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Gap(FSizes.sm),
        Text(
          FTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}
