import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/icons/circular_icon.dart';
import 'package:f_store_dashboard/features/shop/screens/dashboard/responsive_screens/table/data_table.dart';
import 'package:f_store_dashboard/features/shop/screens/dashboard/responsive_screens/widgets/dashboard_card.dart';
import 'package:f_store_dashboard/features/shop/screens/dashboard/responsive_screens/widgets/order_status_graph.dart';
import 'package:f_store_dashboard/features/shop/screens/dashboard/responsive_screens/widgets/weekly_sales.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FHelperFunctions.isDarkMode(context)
          ? Colors.black
          : FColors.primaryBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace / 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Heading
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const Gap(FSizes.spaceBtwSections),

              /// Cards
              Row(
                children: [
                  Expanded(
                    child: FDashboardCard(
                      prefixIcon: FCircularIcon(
                        icon: Iconsax.activity,
                        backgroundColor: FColors.primary.withOpacity(.1),
                        color: FColors.primary,
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
                        color: FColors.success,
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
                        color: Colors.purple,
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
                        color: FColors.error,
                      ),
                      stats: 2,
                      title: 'Visitors',
                      subTitle: '25,953',
                    ),
                  )
                ],
              ),
              const Gap(FSizes.spaceBtwSections),

              /// Bar Graphs
              const FWeeklySalesGraph(),
              const Gap(FSizes.spaceBtwSections),

              /// Orders
              /// Orders
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
              const Gap(FSizes.spaceBtwSections),

              /// Pie Chart
              const OrderStatusGraph()
            ],
          ),
        ),
      ),
    );
  }
}
