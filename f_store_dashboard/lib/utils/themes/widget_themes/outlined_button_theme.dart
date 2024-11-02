import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class FOutlineButtonTheme {
  FOutlineButtonTheme._(); // To avoid creating instances

  /* -- Light Theme -- */
  static final lightOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: FColors.dark,
      side: const BorderSide(color: FColors.borderPrimary),
      textStyle: const TextStyle(
          fontSize: 16, color: FColors.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(
          vertical: FSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          FSizes.buttonHeight,
        ),
      ),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: FColors.light,
      side: const BorderSide(color: FColors.borderPrimary),
      textStyle: const TextStyle(
          fontSize: 16, color: FColors.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(
          vertical: FSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(FSizes.buttonRadius),
      ),
    ),
  );
}
