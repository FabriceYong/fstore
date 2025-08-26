import 'package:f_store_dashboard/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/product_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/products/all_products/table/data_table.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/loaders/normal_animated_loader.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductsDesktopScreen extends StatelessWidget {
  const ProductsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    final isDarkMode = FHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : FColors.primaryBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dashboard Stats Row
              Row(
                children: [
                  // Products Count
                  Expanded(
                    child: _buildStatCard(
                      context,
                      icon: Iconsax.box,
                      title: 'Total Products',
                      value: Obx(() => Text(
                            '${controller.totalProductsCount}', // Use getter
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: FColors.primary,
                                ),
                          )),
                      color: FColors.primary,
                    ),
                  ),
                  const Gap(FSizes.spaceBtwItems),

                  // Low Stock Products
                  Expanded(
                    child: _buildStatCard(
                      context,
                      icon: Iconsax.warning_2,
                      title: 'Low Stock',
                      value: Obx(() => Text(
                            '${controller.lowStockCount}', // Use getter
                            style: Theme.of(context)
                                .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: FColors.warning,
                              ),
                          )), // Add missing parenthesis
                      color: FColors.warning,
                    ),
                  ),
                  const Gap(FSizes.spaceBtwItems),

                  // Out of Stock Products
                  Expanded(
                    child: _buildStatCard(
                      context,
                      icon: Iconsax.empty_wallet,
                      title: 'Out of Stock',
                      value: Obx(() => Text(
                            '${controller.outOfStockCount}', // Use getter
                            style: Theme.of(context)
                                .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: FColors.error,
                              ),
                          )), // Add missing parenthesis
                      color: FColors.error,
                    ),
                  ),
                  const Gap(FSizes.spaceBtwItems),

                  // Featured Products
                  Expanded(
                    child: _buildStatCard(
                      context,
                      icon: Iconsax.star,
                      title: 'Featured Products',
                      value: Obx(() => Text(
                            '${controller.featuredCount}', // Use getter
                            style: Theme.of(context)
                                .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: FColors.success,
                              ),
                          )), // Add missing parenthesis
                      color: FColors.success,
                    ),
                  ),
                ],
              ),

              const Gap(FSizes.spaceBtwSections),

              // Breadcrumbs
              const BreadcrumbWithHeading(
                heading: 'Products',
                breadcrumbItems: ['Products'],
              ),

              const Gap(FSizes.spaceBtwSections),

              // Products Table
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: FLoaderAnimation(),
                  );
                }

                return const FRoundedContainer(
                  padding: EdgeInsets.all(FSizes.md),
                  child: ProductsTable(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build stat cards
  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget value,
    required Color color,
  }) {
    final isDarkMode = FHelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.all(FSizes.md),
      decoration: BoxDecoration(
        color: isDarkMode ? FColors.darkerGrey : FColors.white,
        borderRadius: BorderRadius.circular(FSizes.borderRadiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(FSizes.sm),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(FSizes.borderRadiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const Spacer(),
              Icon(
                Iconsax.arrow_right_3,
                color: isDarkMode ? FColors.white : FColors.darkerGrey,
                size: 20,
              ),
            ],
          ),
          const Gap(FSizes.spaceBtwItems),
          value,
          const Gap(FSizes.xs),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: isDarkMode ? FColors.white : FColors.darkerGrey,
                ),
          ),
        ],
      ),
    );
  }
}
