import 'package:f_store_dashboard/features/shop/screens/dashboard/responsive_screens/widgets/dashboard_card.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DashboardMobileScreen extends StatelessWidget {
  const DashboardMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace / 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dashboard',
                  style: Theme.of(context).textTheme.headlineMedium),
              const Gap(FSizes.spaceBtwSections),

              // Cards
              const FDashboardCard(
                stats: 25,
                title: 'Sales Total',
                subTitle: '\$364.9',
              ),
              const Gap(FSizes.spaceBtwItems / 2),
              const FDashboardCard(
                stats: 14,
                title: 'Average Order Value',
                subTitle: '\$26',
              ),
              const Gap(FSizes.spaceBtwItems / 2),
              const FDashboardCard(
                stats: 44,
                title: 'Total Orders',
                subTitle: '36',
              ),
              const Gap(FSizes.spaceBtwItems / 2),
              const FDashboardCard(
                stats: 2,
                title: 'Visitors',
                subTitle: '25,953',
              )
            ],
          ),
        ),
      ),
    );
  }
}
