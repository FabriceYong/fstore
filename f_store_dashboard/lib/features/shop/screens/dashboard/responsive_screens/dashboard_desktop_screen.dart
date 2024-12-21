import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/shop/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:f_store_dashboard/features/shop/controllers/products_controller/product_images_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/dashboard/responsive_screens/table/data_table.dart';
import 'package:f_store_dashboard/features/shop/screens/dashboard/responsive_screens/widgets/dashboard_card.dart';
import 'package:f_store_dashboard/features/shop/screens/dashboard/responsive_screens/widgets/order_status_graph.dart';
import 'package:f_store_dashboard/features/shop/screens/dashboard/responsive_screens/widgets/weekly_sales.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    final controller = Get.put(DashboardController());
    final productImagesController = Get.put(ProductImagesController());
    return Scaffold(
      backgroundColor: dark ? Colors.black : FColors.light,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dashboard',
                  style: Theme.of(context).textTheme.headlineMedium),
              const Gap(FSizes.spaceBtwSections),

              ElevatedButton(
                  onPressed: () =>
                      productImagesController.selectThumbnailImage(),
                  child: const Text('Select Image')),
              const Gap(FSizes.spaceBtwItems),
              ElevatedButton(
                  onPressed: () =>
                      productImagesController.selectMultipleImages(),
                  child: const Text('Select Multiple Images')),
              const Gap(FSizes.spaceBtwItems),

              // Cards
              const Row(
                children: [
                  Expanded(
                    child: FDashboardCard(
                      stats: 25,
                      title: 'Sales Total',
                      subTitle: '\$364.9',
                    ),
                  ),
                  Gap(FSizes.spaceBtwItems),
                  Expanded(
                    child: FDashboardCard(
                      stats: 14,
                      title: 'Average Order Value',
                      subTitle: '\$26',
                    ),
                  ),
                  Gap(FSizes.spaceBtwItems),
                  Expanded(
                    child: FDashboardCard(
                      stats: 44,
                      title: 'Total Orders',
                      subTitle: '36',
                    ),
                  ),
                  Gap(FSizes.spaceBtwItems),
                  Expanded(
                    child: FDashboardCard(
                      stats: 2,
                      title: 'Visitors',
                      subTitle: '25,953',
                    ),
                  )
                ],
              ),
              const Gap(FSizes.spaceBtwSections),

              /// Graphs
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        /// Bar Graph
                        const FWeeklySalesGraph(),
                        const Gap(FSizes.spaceBtwSections),

                        /// Orders
                        FRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recent Orders',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
