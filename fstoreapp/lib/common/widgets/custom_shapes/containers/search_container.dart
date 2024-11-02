import 'package:flutter/material.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/device/device_utility.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';

class FSearchContainer extends StatelessWidget {
  const FSearchContainer(
      {super.key,
      required this.text,
      this.icon,
      this.showBackground = true,
      this.showBorder = true,
      this.padding = const EdgeInsets.symmetric(horizontal: FSizes.md)});

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    return Padding(
      padding: padding,
      child: Container(
        width: FDeviceUtils.getScreenWidth(),
        padding: const EdgeInsets.all(FSizes.md),
        decoration: BoxDecoration(
          color: showBackground
              ? dark
                  ? FColors.dark
                  : FColors.white
              : Colors.transparent,
          borderRadius: BorderRadius.circular(FSizes.cardRadiusLg),
          border: showBorder ? Border.all(color: FColors.grey) : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: FColors.darkerGrey,
            ),
            const Gap(FSizes.spaceBtwItems),
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
