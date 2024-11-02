
import 'package:flutter/material.dart';
import 'package:fstoreapp/utils/constants/colors.dart';

class FShadowStyles {
  static final verticalProductShadow = BoxShadow(
      color: FColors.darkGrey.withOpacity(.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));

  static final horizontalProductShadow = BoxShadow(
    color: FColors.darkGrey.withOpacity(.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );
}
