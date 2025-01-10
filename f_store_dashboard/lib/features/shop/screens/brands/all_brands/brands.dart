import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/screens/brands/all_brands/responsive_screens/brands_desktop.dart';
import 'package:f_store_dashboard/features/shop/screens/brands/all_brands/responsive_screens/brands_mobile.dart';
import 'package:f_store_dashboard/features/shop/screens/brands/all_brands/responsive_screens/brands_tablet.dart';
import 'package:flutter/material.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FSiteTemplate(
      desktop: BrandsDesktopScreen(),
      tablet: BrandsTabletScreen(),
      mobile: BrandsMobileScreen(),
    );
  }
}
