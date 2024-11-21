import 'package:flutter/material.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Snackbars {
  static hideSnackBar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          // width: MediaQuery.of(Get.context!).size.width * .4,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(Get.context!).brightness == Brightness.dark
                  ? FColors.darkGrey.withOpacity(.9)
                  : FColors.grey.withOpacity(.5)),
          child: Text(
            message,
            style: Theme.of(Get.context!).textTheme.bodyMedium!.apply(
                color: FHelperFunctions.isDarkMode(Get.context!)
                    ? FColors.white
                    : FColors.black),
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
        // maxWidth: MediaQuery.of(Get.context!).size.width * .4,
        colorText: FColors.white,
        backgroundColor: FColors.primary.withOpacity(.8),
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(20),
        icon: const Icon(Iconsax.check, color: FColors.white));
  }

  /// success Snackbar
  static successSnackbarGreen({required title, message = '', duration = 3}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        // maxWidth: MediaQuery.of(Get.context!).size.width * .4,
        colorText: FColors.white,
        backgroundColor: FColors.primary.withOpacity(.2),
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
      // maxWidth: MediaQuery.of(Get.context!).size.width * .4,
      colorText: FColors.white,
      backgroundColor: Colors.orange.withOpacity(.8),
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
      // maxWidth: MediaQuery.of(Get.context!).size.width * .4,
      colorText: FColors.white,
      backgroundColor: Colors.red.withOpacity(.8),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 5),
      icon: const Icon(Icons.error_outline, color: FColors.white),
    );
  }
}
