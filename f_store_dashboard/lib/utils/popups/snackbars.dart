import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Snackbars {
  static _getSnackbarWidth(BuildContext context) {
    final screenWidth = FDeviceUtils.getScreenWidth();

    // Determine width based on screen sizes
    if (FDeviceUtils.isDesktopScreen(context)) {
      return screenWidth * .4;
    } else if (FDeviceUtils.isTabletScreen(context)) {
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
        width: MediaQuery.of(Get.context!).size.width * .4,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(Get.context!).brightness == Brightness.dark
                  ? FColors.darkGrey.withOpacity(.9)
                  : FColors.grey.withOpacity(.9)),
          child: Center(
            child: Text(
              message,
              style: Theme.of(Get.context!).textTheme.bodyLarge,
            ),
          ),
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
