import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/all_categories/responsive_screens/categories_desktop.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/all_categories/responsive_screens/categories_mobile.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/all_categories/responsive_screens/categories_tablet.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FSiteTemplate(
        desktop: CategoriesDesktopScreen(),
        tablet: CategoriesTabletScreen(),
        mobile: CategoriesMobileScreen());
  }
}
