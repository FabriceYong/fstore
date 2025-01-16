import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/screens/products/all_products/responsive_screens/products_desktop.dart';
import 'package:f_store_dashboard/features/shop/screens/products/all_products/responsive_screens/products_mobile.dart';
import 'package:f_store_dashboard/features/shop/screens/products/all_products/responsive_screens/products_tablet.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FSiteTemplate(
      desktop: ProductsDesktopScreen(),
      tablet: ProductsTabletScreen(),
      mobile: ProductsMobileScreen(),
    );
  }
}
