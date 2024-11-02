import 'package:flutter/material.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';

class FCircularIcon extends StatelessWidget {
  const FCircularIcon(
      {super.key,
      this.width,
      this.height,
      this.size = FSizes.lg,
      this.onPressed,
      this.color,
      this.backgroundColor,
      required this.icon});

  final double? width, height, size;
  final IconData icon;
  final Color? color, backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: backgroundColor ??
              (dark
                  ? FColors.black.withOpacity(.9)
                  : FColors.white.withOpacity(.9))),
      child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: color,
            size: size,
          )),
    );
  }
}
