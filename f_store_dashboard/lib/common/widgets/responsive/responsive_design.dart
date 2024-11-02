import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class FResponsiveDesign extends StatelessWidget {
  const FResponsiveDesign(
      {super.key,
      required this.desktop,
      required this.tablet,
      required this.mobile});

  final Widget desktop; // For Desktop layout design
  final Widget tablet; // For Tablet layout design
  final Widget mobile; // For Mobile layout design

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(builder: (_, constraints) {
          if (constraints.maxWidth > FSizes.desktopScreenSize) {
            return desktop;
          } else if (constraints.maxWidth < FSizes.desktopScreenSize &&
              constraints.maxWidth >= FSizes.tabletScreenSize) {
            return tablet;
          } else {
            return mobile;
          }
        }),
      ),
    );
  }
}
