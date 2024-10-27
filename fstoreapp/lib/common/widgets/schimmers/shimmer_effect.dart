import 'package:flutter/material.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:shimmer/shimmer.dart';

class FShimmerEffect extends StatelessWidget {
  const FShimmerEffect(
      {super.key,
      required this.width,
      required this.height,
      this.color,
      this.radius = 15});

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: FHelperFunctions.isDarkMode(context)
          ? Colors.grey[850]!
          : Colors.grey[300]!,
      highlightColor: FHelperFunctions.isDarkMode(context)
          ? Colors.grey[700]!
          : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ??
              (Theme.of(context).brightness == Brightness.dark
                  ? FColors.darkerGrey
                  : FColors.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
