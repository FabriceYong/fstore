import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/screens/orders/all_orders/responsive_screens/orders_desktop.dart';
import 'package:f_store_dashboard/features/shop/screens/orders/all_orders/responsive_screens/orders_mobile.dart';
import 'package:f_store_dashboard/features/shop/screens/orders/all_orders/responsive_screens/orders_tablet.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FSiteTemplate(
      desktop: OrdersDesktopScreen(),
      tablet: OrdersTabletScreen(),
      mobile: OrdersMobileScreen(),
    );
  }
}
