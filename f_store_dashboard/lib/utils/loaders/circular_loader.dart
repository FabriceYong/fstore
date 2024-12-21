import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

/// A circular loader widget with customizable foreground and background colors
class FCircularLoader extends StatelessWidget {
  const FCircularLoader(
      {super.key,
      this.foregroundColor = FColors.white,
      this.backgroundColor = FColors.primary});

  /// Parameters
  /// -foregroundColor: The color of the circular loader
  /// -backgroundColor: The background color of the circular loader
  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(FSizes.lg),
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Center(
        child: CircularProgressIndicator(
          color: foregroundColor,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
