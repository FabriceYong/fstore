import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/personalization/screens/settings/responsive_screens/settings_desktop.dart';
import 'package:f_store_dashboard/features/personalization/screens/settings/responsive_screens/settings_mobile.dart';
import 'package:f_store_dashboard/features/personalization/screens/settings/responsive_screens/settings_tablet.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FSiteTemplate(
      desktop: SettingsDesktopScreen(),
      tablet: SettingsTabletScreen(),
      mobile: SettingsMobileScreen(),
    );
  }
}
