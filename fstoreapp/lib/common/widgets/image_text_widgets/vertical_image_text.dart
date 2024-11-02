import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/images/circular_image.dart';
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
    this.isNetworkImage = true,
    this.onPressed,
  });

  final String image, title;
  final Color? backgroundColor;
  final Color textColor;
  final bool isNetworkImage;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(right: FSizes.spaceBtwItems),
        child: Column(
          children: [
            /// Circular Icon
            FCircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: FSizes.sm * 1.4,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              overlayColor: FHelperFunctions.isDarkMode(context)
                  ? FColors.light
                  : FColors.dark,
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
      ),
    );
  }
}
