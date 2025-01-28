import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/shop/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    final order = DashboardController.orders[index];
    return DataRow2(
      cells: [
        DataCell(
          Text(
            order.id,
            style: Theme.of(Get.context!)
                .textTheme
                .bodyLarge!
                .apply(color: FColors.primary),
          ),
        ),
        DataCell(Text(order.formattedOrderDate)),
        const DataCell(Text('5 items')),
        DataCell(
          FRoundedContainer(
            radius: FSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
                vertical: FSizes.xs, horizontal: FSizes.md),
            backgroundColor: FHelperFunctions.getOrderStatusColor(order.status)
                .withOpacity(.1),
            child: Text(
              order.status.name.capitalize.toString(),
              style: TextStyle(
                  color: FHelperFunctions.getOrderStatusColor(order.status)),
            ),
          ),
        ),
        DataCell(Text('\$${order.totalAmount}'))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => DashboardController.orders.length;

  @override
  int get selectedRowCount => 0;
}
