import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

// A Widget for displaying an animated loading indicator with optional text and action button.

class FAnimationLoaderWidget extends StatelessWidget {
  /// Default constructor for the FAnimationLoaderWidget.
  ///
  /// Parameters:
  /// - text: The text to be displayed below the animation
  /// - animation: The path to the lottie animation file.
  /// - showAction: Whether to show an action button below the text.
  /// - actionText: The text to be displayed on the action button.
  /// - onActionPressed: Callback function to be executed when the action button is pressed.

  const FAnimationLoaderWidget(
      {super.key,
      required this.text,
      required this.animation,
      this.showAction = false,
      this.actionText,
      this.onActionPressed,
      this.height,
      this.width,
      this.style});

  final String text;
  final TextStyle? style;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation,
              height: height ?? MediaQuery.of(context).size.height * .5,
              width: width), // Display Lottie animation
          const Gap(FSizes.defaultSpace),
          Text(
            text,
            style: style ?? Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const Gap(FSizes.defaultSpace),
          if (showAction)
            SizedBox(
              width: 250,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(backgroundColor: FColors.dark),
                onPressed: onActionPressed,
                child: Text(
                  actionText!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: FColors.light),
                ),
              ),
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
