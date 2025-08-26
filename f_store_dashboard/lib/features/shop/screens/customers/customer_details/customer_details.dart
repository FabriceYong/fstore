import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/screens/customers/customer_details/responsive_screens/customer_details_desktop.dart';
import 'package:f_store_dashboard/features/shop/screens/customers/customer_details/responsive_screens/customer_details_mobile.dart';
import 'package:f_store_dashboard/features/shop/screens/customers/customer_details/responsive_screens/customer_details_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDetailsScreen extends StatelessWidget {
  const CustomerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customer = Get.arguments;
    final customerId = Get.parameters['customerId'];
    return FSiteTemplate(
      desktop: CustomerDetailsDesktop(customer: customer),
      tablet: CustomerDetailsTablet(customer: customer),
      mobile: CustomerDetailsMobile(customer: customer),
    );
  }
}
