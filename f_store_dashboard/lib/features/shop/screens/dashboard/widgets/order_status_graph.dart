import 'package:f_store_dashboard/common/widgets/containers/circular_container.dart';
import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/shop/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/loaders/normal_animated_loader.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderStatusGraph extends StatelessWidget {
  const OrderStatusGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return FRoundedContainer(
      padding: const EdgeInsets.all(FSizes.md),
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.black : FColors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Order Status',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Gap(FSizes.spaceBtwSections),

        // Graph
        Obx(
          () => controller.orderStatus.isNotEmpty
              ? SizedBox(
                  height: 400,
                  child: PieChart(
                    PieChartData(
                        sections: controller.orderStatus.entries.map((e) {
                          final status = e.key;
                          final count = e.value;
                          return PieChartSectionData(
                            title: count.toString(),
                            value: count.toDouble(),
                            radius: 100,
                            color: FHelperFunctions.getOrderStatusColor(status),
                            titleStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          );
                        }).toList(),
                        pieTouchData: PieTouchData(touchCallback:
                            (FlTouchEvent event, pieTouchResponse) {
                          // Handle touch events if needed
                        })),
                  ),
                )
              : const SizedBox(
                  height: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [FLoaderAnimation()],
                  ),
                ),
        ),
        const Gap(FSizes.spaceBtwSections),

        // Show Status and Color Meta
        SizedBox(
          width: double.infinity,
          child: Obx(
            () => DataTable(
                columns: const [
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Orders')),
                  DataColumn(label: Text('Total'))
                ],
                rows: controller.orderStatus.entries.map((e) {
                  final OrderStatus status = e.key;
                  final int count = e.value;
                  final totalAmount = controller.totalAmount[status] ?? 0;
                  return DataRow(cells: [
                    DataCell(
                      Row(
                        children: [
                          FCircularContainer(
                              width: 20,
                              height: 20,
                              backgroundColor:
                                  FHelperFunctions.getOrderStatusColor(status)),
                          Expanded(
                              child: Text(
                                  ' ${controller.getDisplayStatusName(status)}'))
                        ],
                      ),
                    ),
                    DataCell(Text(count.toString())),
                    DataCell(Text('\$${totalAmount.toStringAsFixed(2)}'))
                  ]);
                }).toList()),
          ),
        )
      ]),
    );
  }
}
