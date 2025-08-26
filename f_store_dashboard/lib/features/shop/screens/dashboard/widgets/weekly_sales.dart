import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/icons/circular_icon.dart';
import 'package:f_store_dashboard/features/shop/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/loaders/normal_animated_loader.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FWeeklySalesGraph extends StatelessWidget {
  const FWeeklySalesGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return FRoundedContainer(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.black : Colors.white,
      padding: const EdgeInsets.all(FSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FCircularIcon(
                icon: Iconsax.graph,
                backgroundColor: Colors.brown.withOpacity(0.1),
                color: Colors.brown,
                size: FSizes.md,
              ),
              const Gap(FSizes.spaceBtwItems),
              Text(
                'Weekly Sales',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          const Gap(FSizes.spaceBtwSections),

          // Graph
          Obx(
            () => controller.weeklySales.isNotEmpty
                ? SizedBox(
                    height: 400,
                    child: BarChart(
                      BarChartData(
                        titlesData: buildFlTitlesData(controller.weeklySales),
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
                                    borderRadius: BorderRadius.circular(
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
                              getTooltipColor: (_) => FColors.secondary),
                          touchCallback: FDeviceUtils.isDesktopScreen(context)
                              ? (barTouchEvent, barTouchResponse) {}
                              : null,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [FLoaderAnimation()],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

FlTitlesData buildFlTitlesData(List<double> weeklySales) {
  final maxOrder = weeklySales.reduce((a, b) => a > b ? a : b).toDouble();
  final stepHeight = (maxOrder / 10).ceilToDouble();
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
    leftTitles: AxisTitles(
        sideTitles: SideTitles(
            showTitles: true,
            interval: stepHeight <= 0 ? 500 : stepHeight,
            reservedSize: 50)),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );
}
