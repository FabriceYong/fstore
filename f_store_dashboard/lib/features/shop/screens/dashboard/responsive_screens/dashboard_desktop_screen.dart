import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/shop/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/dashboard/responsive_screens/widgets/dashboard_card.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    final controller = Get.put(DashboardController());
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
              ),
              const Gap(FSizes.spaceBtwSections),

              /// Graphs
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        /// Bar Graph
                        FRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Weekly Sales',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const Gap(FSizes.spaceBtwSections),

                              // Graph
                              SizedBox(
                                height: 400,
                                child: BarChart(
                                  BarChartData(
                                      titlesData: buildFlTitlesData(),
                                      borderData: FlBorderData(
                                        show: true,
                                        border: const Border(
                                          top: BorderSide.none,
                                          right: BorderSide.none,
                                        ),
                                      ),
                                      gridData: const FlGridData(
                                        show: true,
                                        drawHorizontalLine: true,
                                        drawVerticalLine: false,
                                        horizontalInterval: 200,
                                      ),
                                      barGroups: controller.weeklySales
                                          .asMap()
                                          .entries
                                          .map(
                                            (entry) => BarChartGroupData(
                                              x: entry.key,
                                              barRods: [
                                                BarChartRodData(
                                                  toY: entry.value,
                                                  width: 30,
                                                  color: FColors.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    FSizes.sm,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                          .toList(),
                                      groupsSpace: FSizes.spaceBtwItems,
                                      barTouchData: BarTouchData(
                                        touchTooltipData: BarTouchTooltipData(
                                            getTooltipColor: (_) =>
                                                FColors.secondary),
                                        touchCallback:
                                            FDeviceUtils.isDesktopScreen(
                                                    context)
                                                ? (barTouchEvent,
                                                    barTouchResponse) {}
                                                : null,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Gap(FSizes.spaceBtwSections),

                        /// Orders
                        const FRoundedContainer(),
                      ],
                    ),
                  ),
                  const Gap(FSizes.spaceBtwSections),

                  /// Pie Chart
                  const Expanded(child: FRoundedContainer())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  FlTitlesData buildFlTitlesData() {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                // Map index to the desired day of the week
                final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

                // Calculate the index and ensure it wraps around for the correct day
                final index = value.toInt() % days.length;

                // Get the day corresponding to the calculated index
                final day = days[index];

                return SideTitleWidget(
                  axisSide: AxisSide.bottom,
                  space: 0,
                  child: Text(day),
                );
              })),
      leftTitles: const AxisTitles(
          sideTitles:
              SideTitles(showTitles: true, interval: 1000, reservedSize: 50)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}