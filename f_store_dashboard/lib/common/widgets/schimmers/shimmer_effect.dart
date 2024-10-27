
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FShimmerEffect extends StatelessWidget {
  const FShimmerEffect(
      {super.key,
      required this.width,
      required this.height,
      this.radius = 15,
      this.color,});

  final double width, height, radius;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[850]!
          : Colors.grey[300]!,
      highlightColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[700]!
          : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (Theme.of(context).brightness == Brightness.dark ? FColors.darkerGrey : FColors.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
