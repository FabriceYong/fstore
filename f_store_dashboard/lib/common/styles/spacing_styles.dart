import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class FSpacingStyles {
  FSpacingStyles._();
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: FSizes.appBarHeight,
    left: FSizes.defaultSpace,
    bottom: FSizes.defaultSpace,
    right: FSizes.defaultSpace,
  );
}
