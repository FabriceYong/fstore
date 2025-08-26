import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/icons/circular_icon.dart';
import 'package:f_store_dashboard/features/shop/controllers/dashboard_controller/dashboard_controller.dart';
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

class DashboardMobileScreen extends StatelessWidget {
  const DashboardMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Scaffold(
      backgroundColor: FHelperFunctions.isDarkMode(context)
          ? Colors.black
          : FColors.primaryBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
              FSizes.defaultSpace / 2), // Adjusted padding slightly
          child: Obx(
            () {
              // Calculate derived stats
              final double totalSalesAmount = controller.totalAmount.values
                  .fold(0.0, (sum, amount) => sum + amount);
              final int totalOrdersCount = controller.orderStatus.values
                  .fold(0, (sum, count) => sum + count);
              final int totalOrdersFromList =
                  DashboardController.instance.allItems.length;
              final double averageOrderValue =
                  (controller.orderController.allItems.fold(
                          0.0,
                          (previousValue, element) =>
                              previousValue + element.totalAmount) /
                      controller.orderController.allItems.length);

              // Formatters
              final currencyFormatter =
                  NumberFormat.currency(symbol: '\$', decimalDigits: 1);
              final compactFormatter = NumberFormat.compact();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dashboard',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const Gap(FSizes.spaceBtwSections),

                  // Cards - Using ListView for better scrolling on mobile if needed, or Column
                  // SALES TOTAL
                  Obx(
                    () => FDashboardCard(
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
                  Obx(
                    () => FDashboardCard(
                      prefixIcon: FCircularIcon(
                        icon: Iconsax.box,
                        backgroundColor: FColors.success.withOpacity(.1),
                        color: FColors.success.withOpacity(.9),
                      ),
                      stats: 14, // Placeholder
                      title: 'Average Order Value',
                      subTitle: currencyFormatter.format(
                          controller.orderController.allItems.fold(
                              0.0,
                              (previousValue, element) =>
                                  (previousValue + element.totalAmount) /
                                  controller.orderController.allItems.length)),
                    ),
                  ),
                  const Gap(FSizes.spaceBtwItems),

                  // TOTAL ORDERS
                  Obx(
                    () => FDashboardCard(
                        prefixIcon: FCircularIcon(
                          icon: Iconsax.box,
                          backgroundColor: Colors.purple.withOpacity(.1),
                          color: Colors.purple.withOpacity(.9),
                        ),
                        stats: totalOrdersCount, // Using calculated count
                        title: 'Total Orders',
                        subTitle:
                            '${controller.orderController.allItems.length}'),
                  ),
                  const Gap(FSizes.spaceBtwItems),

                  // VISITORS
                  Obx(
                    () => FDashboardCard(
                      prefixIcon: FCircularIcon(
                        icon: Iconsax.user,
                        backgroundColor: FColors.error.withOpacity(.1),
                        color: FColors.error.withOpacity(.9),
                      ),
                      stats: 2, // Placeholder
                      title: 'Visitors',
                      subTitle: NumberFormat.compact().format(controller
                          .customerController.allItems.length), // Placeholder
                    ),
                  ),
                  const Gap(FSizes.spaceBtwSections),

                  /// Bar Graph,
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
                        const DashboardOrderTable(), // Consider a simpler list view for mobile?
                      ],
                    ),
                  ),
                  const Gap(FSizes.spaceBtwSections),

                  /// Pie Chart
                  const OrderStatusGraph(),
                  const Gap(FSizes.spaceBtwSections),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
