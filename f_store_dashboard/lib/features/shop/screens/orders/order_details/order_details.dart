import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/models/order_model/order_model.dart';
import 'package:f_store_dashboard/features/shop/screens/orders/order_details/responsive_screens/order_details_desktop.dart';
import 'package:f_store_dashboard/features/shop/screens/orders/order_details/responsive_screens/order_details_mobile.dart';
import 'package:f_store_dashboard/features/shop/screens/orders/order_details/responsive_screens/order_details_tablet.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = OrderModel(
        id: 'id',
        status: OrderStatus.pending,
        totalAmount: 0.00,
        orderDate: DateTime.now(),
        items: []);
    return FSiteTemplate(
        desktop: OrderDetailsDesktop(order: order),
        tablet: OrderDetailsTablet(order: order),
        mobile: OrderDetailsMobile(order: order));
  }
}
