
import 'package:flutter/material.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';

class FSpacingStyles {
  FSpacingStyles._();
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
      top: FSizes.appBarHeight,
      left: FSizes.defaultSpace,
      bottom: FSizes.defaultSpace,
      right: FSizes.defaultSpace);
}
