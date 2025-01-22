import 'package:f_store_dashboard/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:f_store_dashboard/features/shop/models/order_model/order_model.dart';
import 'package:f_store_dashboard/features/shop/screens/orders/order_details/widgets/order_customer.dart';
import 'package:f_store_dashboard/features/shop/screens/orders/order_details/widgets/order_info.dart';
import 'package:f_store_dashboard/features/shop/screens/orders/order_details/widgets/order_items.dart';
import 'package:f_store_dashboard/features/shop/screens/orders/order_details/widgets/order_transactions.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrderDetailsMobile extends StatelessWidget {
  const OrderDetailsMobile({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? Colors.black : FColors.primaryBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const BreadcrumbWithHeading(
                returnToPrevScreen: true,
                heading: 'Order Details',
                breadcrumbItems: [FRoutes.orderDetails, 'Order Details'],
              ),
              const Gap(FSizes.spaceBtwItems),

              // Body
              Column(
                children: [
                  // Order Info
                  OrderInfo(order: order),
                  const Gap(FSizes.spaceBtwSections),

                  // Order Items
                  OrderItems(order: order),
                  const Gap(FSizes.spaceBtwSections),

                  // Order Transactions
                  OrderTransactions(order: order),
                ],
              ),
              const Gap(FSizes.spaceBtwSections),

              // Right Side Orders
              Column(
                children: [
                  OrderCustomer(order: order),
                  const Gap(FSizes.spaceBtwSections)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
