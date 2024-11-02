import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class FCheckboxTheme {
  FCheckboxTheme._(); // to avoid creating instances

  /// Customizable Light Text Theme
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(FSizes.xs),), checkColor: WidgetStateProperty.resolveWith((states) {
    if(states.contains(WidgetState.selected)) {
      return FColors.white;
    }else{
      return FColors.black;
    }
  }), fillColor: WidgetStateProperty.resolveWith((states){
    if(states.contains(WidgetState.selected)){
      return FColors.primary;
    }else{
      return Colors.transparent;
    }
  }),);

  /// Customizable Dark Text Theme
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(FSizes.xs)), checkColor: WidgetStateProperty.resolveWith((states) {
    if(states.contains(WidgetState.selected)){
      return FColors.white;
    }else {
      return FColors.black;
    }
  }), fillColor: WidgetStateProperty.resolveWith((states) {
    if(states.contains(WidgetState.selected)){
      return FColors.primary;
    }else{
      return Colors.transparent;
    }
  }));
}