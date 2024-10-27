import 'package:flutter/material.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';

class FRoundedContainer extends StatelessWidget {
  const FRoundedContainer(
      {super.key,
      this.child,
      this.height,
      this.width,
      this.margin,
      this.padding,
      this.showBorder = false,
      this.radius = FSizes.cardRadiusLg,
      this.backgroundColor = FColors.white,
      this.borderColor = FColors.borderPrimary});

  final double? width, height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor, backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: borderColor) : null),
      child: child,
    );
  }
}
