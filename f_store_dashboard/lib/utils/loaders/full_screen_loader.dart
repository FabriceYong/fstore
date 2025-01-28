// A Utility class for managing a full-screen loading dialog.
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/loaders/animation_loader.dart';
import 'package:f_store_dashboard/utils/loaders/circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FFullScreenLoader {
  /// Open a full-screen loading dialog with a given text and animation
  /// This method doesn't return anything
  ///
  /// Parameters:
  /// - text: The text to be displayed in the loading dialog
  /// - animation: The lottie animation to be shown.
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context:
          Get.overlayContext!, // Use Get.overlayContext for overlay dialogs
      barrierDismissible:
          false, // The dialog can't be dismissed by tapping outside it
      builder: (_) => PopScope(
        canPop:
            false, // Disable popping back to the previous screen with the back button
        child: Container(
          color: FHelperFunctions.isDarkMode(Get.context!)
              ? Colors.black
              : Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const Gap(250),
              FAnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  static void popUpCircular() {
    Get.defaultDialog(
      title: '',
      onWillPop: () async => false,
      content: const FCircularLoader(),
      backgroundColor: Colors.transparent,
    );
  }

  /// Stop the currently open loading dialog
  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
