import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/text/brand_title_text.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/enums.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class FBrandTitleTextWithVerifiedIcon extends StatelessWidget {
  const FBrandTitleTextWithVerifiedIcon(
      {super.key,
      this.textColor,
      this.maxLines = 1,
      this.iconColor = FColors.primary,
      this.textAlign = TextAlign.center,
      this.brandTextSize = TextSizes.small,
      required this.title});

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            child: FBrandTitleText(
          title: title,
          color: textColor,
          maxLines: maxLines,
          textAlign: textAlign,
          brandTextSize: brandTextSize,
        )),
        const Gap(FSizes.xs),
        Icon(
          Iconsax.verify5,
          color: iconColor,
          size: FSizes.iconXs,
        )
      ],
    );
  }
}
