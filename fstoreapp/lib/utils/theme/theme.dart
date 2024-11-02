import 'package:flutter/material.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/theme/widget_themes/appbar_theme.dart';
import 'package:fstoreapp/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:fstoreapp/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:fstoreapp/utils/theme/widget_themes/chip_theme.dart';
import 'package:fstoreapp/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:fstoreapp/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:fstoreapp/utils/theme/widget_themes/text_field_theme.dart';
import 'package:fstoreapp/utils/theme/widget_themes/text_theme.dart';

class FAppTheme {
  FAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: FColors.grey,
    brightness: Brightness.light,
    primaryColor: FColors.primary,
    textTheme: FTextTheme.lightTextTheme,
    chipTheme: FChipTheme.lightChipTheme,
    scaffoldBackgroundColor: FColors.white,
    appBarTheme: FAppBarTheme.lightAppBarTheme,
    checkboxTheme: FCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: FBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: FElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: FOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: FTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: FColors.grey,
    brightness: Brightness.dark,
    primaryColor: FColors.primary,
    textTheme: FTextTheme.darkTextTheme,
    chipTheme: FChipTheme.darkChipTheme,
    scaffoldBackgroundColor: FColors.black,
    appBarTheme: FAppBarTheme.darkAppBarTheme,
    checkboxTheme: FCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: FBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: FElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: FOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: FTextFormFieldTheme.darkInputDecorationTheme,
  );
}
