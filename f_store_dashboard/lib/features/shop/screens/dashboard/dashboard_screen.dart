import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/screens/dashboard/responsive_screens/dashboard_desktop_screen.dart';
import 'package:f_store_dashboard/features/shop/screens/dashboard/responsive_screens/dashboard_mobile_screen.dart';
import 'package:f_store_dashboard/features/shop/screens/dashboard/responsive_screens/dashboard_tablet_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FSiteTemplate(
      desktop: DashboardDesktopScreen(),
      tablet: DashboardTabletScreen(),
      mobile: DashboardMobileScreen(),
    );
  }
}
