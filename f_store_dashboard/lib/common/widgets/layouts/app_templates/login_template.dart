import 'package:f_store_dashboard/common/styles/spacing_styles.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class FLoginTemplate extends StatelessWidget {
  const FLoginTemplate({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Container(
            padding: FSpacingStyles.paddingWithAppBarHeight,
            decoration: BoxDecoration(
              color: dark ? FColors.black : FColors.white,
              borderRadius: BorderRadius.circular(FSizes.cardRadiusLg),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
