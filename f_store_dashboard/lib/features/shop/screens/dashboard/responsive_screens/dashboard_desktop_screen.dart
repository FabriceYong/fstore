import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/icons/circular_icon.dart';
import 'package:f_store_dashboard/features/shop/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:f_store_dashboard/features/shop/controllers/products_controller/product_images_controller.dart';
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

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    final controller = Get.put(DashboardController());
    final productImagesController = Get.put(ProductImagesController());
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
              Row(
                children: [
                  Expanded(
                    child: FDashboardCard(
                      prefixIcon: FCircularIcon(
                        icon: Iconsax.activity,
                        backgroundColor: FColors.primary.withOpacity(.1),
                        color: FColors.primary.withOpacity(.9),
                      ),
                      stats: 25,
                      title: 'Sales Total',
                      subTitle: '\$364.9',
                    ),
                  ),
                  const Gap(FSizes.spaceBtwItems),
                  Expanded(
                    child: FDashboardCard(
                      prefixIcon: FCircularIcon(
                        icon: Iconsax.box,
                        backgroundColor: FColors.success.withOpacity(.1),
                        color: FColors.success.withOpacity(.9),
                      ),
                      stats: 14,
                      title: 'Average Order Value',
                      subTitle: '\$26',
                    ),
                  ),
                  const Gap(FSizes.spaceBtwItems),
                  Expanded(
                    child: FDashboardCard(
                      prefixIcon: FCircularIcon(
                        icon: Iconsax.box,
                        backgroundColor: Colors.purple.withOpacity(.1),
                        color: Colors.purple.withOpacity(.9),
                      ),
                      stats: 44,
                      title: 'Total Orders',
                      subTitle: '36',
                    ),
                  ),
                  const Gap(FSizes.spaceBtwItems),
                  Expanded(
                    child: FDashboardCard(
                      prefixIcon: FCircularIcon(
                        icon: Iconsax.user,
                        backgroundColor: FColors.error.withOpacity(.1),
                        color: FColors.error.withOpacity(.9),
                      ),
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
