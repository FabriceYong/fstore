import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/screens/customers/all_customers/responsive_screens/customers_desktop.dart';
import 'package:f_store_dashboard/features/shop/screens/customers/all_customers/responsive_screens/customers_mobile.dart';
import 'package:f_store_dashboard/features/shop/screens/customers/all_customers/responsive_screens/customers_tablet.dart';
import 'package:flutter/material.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FSiteTemplate(desktop: CustomersDesktopScreen(), tablet: CustomersTabletScreen(), mobile: CustomersMobileScreen(),);
  }
}