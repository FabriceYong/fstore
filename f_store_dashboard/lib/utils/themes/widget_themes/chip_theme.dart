import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class FChipTheme {
  FChipTheme._(); // Avoid creating instances

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: FColors.grey.withOpacity(.4),
    labelStyle: const TextStyle(color: FColors.black),
    selectedColor: FColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    checkmarkColor: FColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: FColors.darkGrey,
    labelStyle: TextStyle(color: FColors.white),
    selectedColor: FColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    checkmarkColor: FColors.white,
  );
}
