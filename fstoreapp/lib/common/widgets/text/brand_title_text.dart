import 'package:flutter/material.dart';
import 'package:fstoreapp/utils/constants/enums.dart';

class FBrandTitleText extends StatelessWidget {
  const FBrandTitleText(
      {super.key,
      this.color,
      this.maxLines = 1,
      this.textAlign = TextAlign.center,
      required this.title,
      this.brandTextSize = TextSizes.small});

  final Color? color;
  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      // Check which brand is required and set that style.
      style: brandTextSize == TextSizes.small
          ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
          : brandTextSize == TextSizes.medium
              ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
              : brandTextSize == TextSizes.large
                  ? Theme.of(context).textTheme.titleLarge!.apply(color: color)
                  : Theme.of(context).textTheme.bodyMedium!.apply(color: color),
    );
  }
}