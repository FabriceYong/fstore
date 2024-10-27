import 'package:flutter/material.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';

class FVerticalImageText extends StatelessWidget {
  const FVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.backgroundColor,
    this.textColor = FColors.white,
    this.onPressed,
  });

  final String image, title;
  final Color? backgroundColor;
  final Color textColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(FSizes.sm),
            decoration: BoxDecoration(
              color: backgroundColor ??
                  (FHelperFunctions.isDarkMode(context)
                      ? FColors.black
                      : FColors.white),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                color: FHelperFunctions.isDarkMode(context)
                    ? FColors.white
                    : FColors.dark,
              ),
            ),
          ),

          /// Text
          const Gap(FSizes.spaceBtwItems / 2),
          SizedBox(
            width: 55,
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: textColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
