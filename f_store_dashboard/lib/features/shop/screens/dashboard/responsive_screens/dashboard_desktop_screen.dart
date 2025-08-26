import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/icons/circular_icon.dart';
import 'package:f_store_dashboard/features/shop/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/product_images_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/dashboard/table/data_table.dart';
import 'package:f_store_dashboard/features/shop/screens/dashboard/widgets/dashboard_card.dart';
import 'package:f_store_dashboard/features/shop/screens/dashboard/widgets/order_status_graph.dart';
import 'package:f_store_dashboard/features/shop/screens/dashboard/widgets/weekly_sales.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    final controller = Get.find<DashboardController>();
    final productImagesController = Get.find<ProductImagesController>();
    return Scaffold(
      backgroundColor: dark ? Colors.black : FColors.primaryBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dashboard',
                  style: Theme.of(context).textTheme.headlineMedium),
              const Gap(FSizes.spaceBtwSections),

              // Cards Row
              _DashboardCardsRow(controller: controller),
              const Gap(FSizes.spaceBtwSections),

              /// Graphs & Orders Row
              const _DashboardGraphsAndOrdersRow(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget for the row containing graphs and the recent orders table.
class _DashboardGraphsAndOrdersRow extends StatelessWidget {
  const _DashboardGraphsAndOrdersRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              /// Bar Graph
              const FWeeklySalesGraph(),
              const Gap(FSizes.spaceBtwSections),

              /// Orders Table
              FRoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent Orders',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Gap(FSizes.spaceBtwSections),
                    const DashboardOrderTable(),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Gap(FSizes.spaceBtwSections),

        /// Pie Chart
        const Expanded(child: OrderStatusGraph())
      ],
    );
  }
}

/// Widget for the row displaying dashboard summary cards.
class _DashboardCardsRow extends StatelessWidget {
  const _DashboardCardsRow({required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    // Calculate derived stats
    final double totalSalesAmount =
        controller.totalAmount.values.fold(0.0, (sum, amount) => sum + amount);
    final int totalOrdersCount =
        controller.orderStatus.values.fold(0, (sum, count) => sum + count);
    // Use DashboardController.orders.length for total orders if orderStatus doesn't represent all orders
    final int totalOrdersFromList = controller.orderController.allItems.length;
    final double averageOrderValue =
        totalOrdersFromList > 0 ? totalSalesAmount / totalOrdersFromList : 0.0;

    // Formatters
    final currencyFormatter =
        NumberFormat.currency(symbol: '\$', decimalDigits: 1);
    final compactFormatter =
        NumberFormat.compact(); // For large numbers like visitors

    return Row(
      children: [
        // SALES TOTAL
        Expanded(
          child: FDashboardCard(
            prefixIcon: FCircularIcon(
              icon: Iconsax.activity,
              backgroundColor: FColors.primary.withOpacity(.1),
              color: FColors.primary.withOpacity(.9),
            ),
            stats: 25, // Placeholder
            title: 'Sales Total',
            subTitle: currencyFormatter.format(
                controller.orderController.allItems.fold(
                    0.0,
                    (previousValue, element) =>
                        previousValue + element.totalAmount)),
          ),
        ),
        const Gap(FSizes.spaceBtwItems),

        // AVERAGE ORDER VALUE
        Expanded(
            child: FDashboardCard(
          prefixIcon: FCircularIcon(
            icon: Iconsax.box,
            backgroundColor: FColors.success.withOpacity(.1),
            color: FColors.success.withOpacity(.9),
          ),
          stats: 14, // Placeholder
          title: 'Average Order Value',
          subTitle: currencyFormatter.format(controller.orderController.allItems
              .fold(
                  0.0,
                  (previousValue, element) =>
                      (previousValue + element.totalAmount) /
                      controller.orderController.allItems.length)),
        )),
        const Gap(FSizes.spaceBtwItems),

        //TOTAL ORDERS COUNT
        Expanded(
          child: FDashboardCard(
            prefixIcon: FCircularIcon(
              icon: Iconsax.box,
              backgroundColor: Colors.purple.withOpacity(.1),
              color: Colors.purple.withOpacity(.9),
            ),
            stats: totalOrdersCount, // Using calculated count
            title: 'Total Orders',
            subTitle: controller.orderController.allItems.length.toString(),
          ),
        ),
        const Gap(FSizes.spaceBtwItems),

        // VISITORS
        Expanded(
          child: FDashboardCard(
            prefixIcon: FCircularIcon(
              icon: Iconsax.user,
              backgroundColor: FColors.error.withOpacity(.1),
              color: FColors.error.withOpacity(.9),
            ),
            stats: 2, // Placeholder
            title: 'Visitors',
            subTitle: compactFormatter.format(
                controller.customerController.allItems.length), // Placeholder
          ),
        ),
      ],
    );
  }
}
