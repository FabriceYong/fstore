import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/personalization/screens/profile/responsive_screens/profile_desktop.dart';
import 'package:f_store_dashboard/features/personalization/screens/profile/responsive_screens/profile_mobile.dart';
import 'package:f_store_dashboard/features/personalization/screens/profile/responsive_screens/profile_tablet.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FSiteTemplate(
      desktop: ProfileDesktopScreen(),
      tablet: ProfileTabletScreen(),
      mobile: ProfileMobileScreen(),
    );
  }
}
