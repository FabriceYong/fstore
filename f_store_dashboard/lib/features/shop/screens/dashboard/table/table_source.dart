import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/shop/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderRows extends DataTableSource {
  final controller = DashboardController.instance;
  @override
  DataRow? getRow(int index) {
    final order = controller.orderController.filteredItems[index];
    return DataRow2(
      onTap: () => Get.toNamed(FRoutes.orderDetails,
          arguments: order, parameters: {'orderId': order.id}),
      selected: controller.selectedRows[index],
      onSelectChanged: (value) =>
          controller.selectedRows[index] = value ?? false,
      color: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return FHelperFunctions.isDarkMode(Get.context!)
              ? FColors.primary.withOpacity(.2)
              : FColors.primary.withOpacity(.1);
        } else {
          return FHelperFunctions.isDarkMode(Get.context!)
              ? Colors.grey.shade800.withOpacity(.3)
              : Colors.grey.withOpacity(.2);
        }
      }),
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
        DataCell(Text('${order.items.length}')),
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
  int get rowCount => controller.filteredItems.length;
  
  @override
  int get selectedRowCount =>
      controller.selectedRows.where((selected) => selected).length;
}
