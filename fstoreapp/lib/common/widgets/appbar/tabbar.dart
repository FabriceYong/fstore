import 'package:flutter/material.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/device/device_utility.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';

class FTabBar extends StatelessWidget implements PreferredSizeWidget {
  const FTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          FHelperFunctions.isDarkMode(context) ? FColors.black : FColors.white,
      child: TabBar(
        isScrollable: true,
        indicatorColor: FColors.primary,
        unselectedLabelColor: FColors.darkGrey,
        labelColor: FHelperFunctions.isDarkMode(context)
            ? FColors.white
            : FColors.primary,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: tabs,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(FDeviceUtils.getAppBarHeight());
}
