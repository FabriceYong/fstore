import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FLoginHeader extends StatelessWidget {
  const FLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            width: 100,
            height: 100,
            image:
                AssetImage(dark ? FImages.lightAppLogo : FImages.darkAppLogo),
          ),
          const Gap(FSizes.spaceBtwSections),
          Text(
            FTexts.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap(FSizes.sm),
          Text(
            FTexts.loginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
