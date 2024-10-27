import 'package:f_store_dashboard/features/authentication/screens/dashboard/responsive_screens/widgets/dashboard_card.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dashboard',
                  style: Theme.of(context).textTheme.headlineMedium),
              const Gap(FSizes.spaceBtwSections),

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
              )
            ],
          ),
        ),
      ),
    );
  }
}
