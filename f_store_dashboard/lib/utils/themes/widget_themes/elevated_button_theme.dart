import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class FElevatedButtonTheme {
  FElevatedButtonTheme._(); // To avoid creating instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: FColors.light,
      foregroundColor: FColors.primary,
      disabledForegroundColor: FColors.darkGrey,
      disabledBackgroundColor: FColors.buttonDisabled,
      side: const BorderSide(color: FColors.primary),
      padding: const EdgeInsets.symmetric(vertical: FSizes.buttonHeight),
      textStyle: const TextStyle(
          fontSize: 16, color: FColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(FSizes.buttonRadius),
      ),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: FColors.light,
      backgroundColor: FColors.primary,
      disabledBackgroundColor: FColors.darkerGrey,
      disabledForegroundColor: FColors.darkGrey,
      side: const BorderSide(color: FColors.primary),
      padding: const EdgeInsets.symmetric(vertical: FSizes.buttonHeight),
      textStyle: const TextStyle(
        fontSize: 16,
        color: FColors.textWhite,
        fontWeight: FontWeight.w600,
      ),
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(FSizes.buttonRadius),
      ),
    ),
  );
}
