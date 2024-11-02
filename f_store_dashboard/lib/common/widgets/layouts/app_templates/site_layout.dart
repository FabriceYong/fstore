import 'package:f_store_dashboard/common/widgets/responsive/responsive_design.dart';
import 'package:f_store_dashboard/common/widgets/responsive/screens/desktop_layout.dart';
import 'package:f_store_dashboard/common/widgets/responsive/screens/mobile_layout.dart';
import 'package:f_store_dashboard/common/widgets/responsive/screens/tablet_layout.dart';
import 'package:flutter/material.dart';

class FSiteTemplate extends StatelessWidget {
  const FSiteTemplate(
      {super.key,
      this.desktop,
      this.tablet,
      this.mobile,
      this.useLayout = true});

  /// Widget for Desktop Layout
  final Widget? desktop;

  /// Widget for Tablet Layout
  final Widget? tablet;

  /// Widget for Mobile Layout
  final Widget? mobile;

  /// Flag to determine whether to use the layout
  final bool useLayout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      body: FResponsiveDesign(
        desktop: useLayout
            ? DesktopLayout(
                body: desktop,
              )
            : desktop ?? Container(),
        tablet: useLayout
            ? TabletLayout(
                body: tablet ?? desktop,
              )
            : tablet ?? desktop ?? Container(),
        mobile: useLayout
            ? MobileLayout(
                body: mobile ?? desktop,
              )
            : mobile ?? desktop ?? Container(),
      ),
    );
  }
}
