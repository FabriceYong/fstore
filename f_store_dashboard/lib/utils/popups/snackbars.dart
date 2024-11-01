import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Snackbars {
  static _getSnackbarWidth(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Define breakpoints for tablet and desktop
    const double tabletBreakpoint = 768.0;
    const double desktopBreakpoint = 1024.0;

    // Determine width based on screen sizes
    if (screenWidth >= desktopBreakpoint) {
      return screenWidth * .4;
    } else if (screenWidth >= tabletBreakpoint &&
        screenWidth < desktopBreakpoint) {
      return screenWidth * .6;
    } else {
      return screenWidth * .95;
    }
  }

  static hideSnackBar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          width: MediaQuery.of(Get.context!).size.width * .4,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(Get.context!).brightness == Brightness.dark
                  ? FColors.darkGrey.withOpacity(.9)
                  : FColors.grey.withOpacity(.0)),
        ),
      ),
    );
  }

  /// success Snackbar
  static successSnackbar({required title, message = '', duration = 3}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        maxWidth: _getSnackbarWidth(Get.context!),
        colorText: FColors.white,
        backgroundColor: FColors.primary.withOpacity(.5),
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(20),
        icon: const Icon(Iconsax.check, color: FColors.white));
  }

  /// Warning snackbar
  static warningSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      maxWidth: _getSnackbarWidth(Get.context!),
      colorText: FColors.white,
      backgroundColor: Colors.orange.withOpacity(.5),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      icon: const Icon(
        Iconsax.warning_2,
        color: FColors.white,
      ),
    );
  }

  /// Error Snackbar
  static errorSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      maxWidth: _getSnackbarWidth(Get.context!),
      colorText: FColors.white,
      backgroundColor: Colors.red.withOpacity(.5),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 5),
      icon: const Icon(Icons.error_outline, color: FColors.white),
    );
  }
}
