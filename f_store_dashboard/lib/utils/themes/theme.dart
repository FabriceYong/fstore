import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/themes/widget_themes/app_bar_theme.dart';
import 'package:f_store_dashboard/utils/themes/widget_themes/bottom_sheet_theme.dart';
import 'package:f_store_dashboard/utils/themes/widget_themes/checkbox_theme.dart';
import 'package:f_store_dashboard/utils/themes/widget_themes/chip_theme.dart';
import 'package:f_store_dashboard/utils/themes/widget_themes/elevated_button_theme.dart';
import 'package:f_store_dashboard/utils/themes/widget_themes/outlined_button_theme.dart';
import 'package:f_store_dashboard/utils/themes/widget_themes/text_field_theme.dart';
import 'package:f_store_dashboard/utils/themes/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

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
    outlinedButtonTheme: FOutlineButtonTheme.lightOutlineButtonTheme,
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
    scaffoldBackgroundColor: FColors.white,
    appBarTheme: FAppBarTheme.darkAppBarTheme,
    checkboxTheme: FCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: FBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: FElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: FOutlineButtonTheme.darkOutlineButtonTheme,
    inputDecorationTheme: FTextFormFieldTheme.darkInputDecorationTheme,
  );
}
