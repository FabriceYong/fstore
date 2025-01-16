import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/screens/banners/all_banners/responsive_screens/banners_desktop.dart';
import 'package:f_store_dashboard/features/shop/screens/banners/all_banners/responsive_screens/banners_mobile.dart';
import 'package:f_store_dashboard/features/shop/screens/banners/all_banners/responsive_screens/banners_tablet.dart';
import 'package:flutter/material.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FSiteTemplate(
      desktop: BannersDesktopScreen(),
      tablet: BannersTabletScreen(),
      mobile: BannersMobileScreen(),
    );
  }
}
