import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/shop/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:f_store_dashboard/features/shop/controllers/order_controller/order_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/all_categories/widgets/table_action_buttons.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTableRows extends DataTableSource {
  final controller = OrderController.instance;
  @override
  DataRow? getRow(int index) {
    final order = DashboardController.instance.orderController.allItems[index];
    return DataRow2(
        onTap: () => Get.toNamed(FRoutes.orderDetails,
            arguments: order, parameters: {'orderId': order.docId}),
        selected: controller.selectedRows[index],
        onSelectChanged: (value) =>
            controller.selectedRows[index] = value ?? false,
        color:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return FHelperFunctions.isDarkMode(Get.context!)
                ? FColors.primary.withOpacity(.2)
                : FColors.primary.withOpacity(.1);
          }
          if (states.contains(WidgetState.hovered)) {
            return FHelperFunctions.isDarkMode(Get.context!)
                ? Colors.grey.shade800
                : Colors.grey.withOpacity(.3);
          }
          return null;
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
          DataCell(Text('${order.items.length} Items')),
          DataCell(
            FRoundedContainer(
              radius: FSizes.cardRadiusSm,
              padding: const EdgeInsets.symmetric(
                  vertical: FSizes.sm, horizontal: FSizes.md),
              backgroundColor:
                  FHelperFunctions.getOrderStatusColor(order.status)
                      .withOpacity(.1),
              child: Text(
                order.status.name.capitalize.toString(),
                style: TextStyle(
                  color: FHelperFunctions.getOrderStatusColor(order.status),
                ),
              ),
            ),
          ),
          DataCell(Text('\$${order.totalAmount}')),
          DataCell(
            FTableActionButtons(
              view: true,
              edit: false,
              onViewPressed: () => Get.toNamed(FRoutes.orderDetails,
                  arguments: order, parameters: {'orderId': order.docId}),
              onDeletePressed: () => controller.confirmDeleteItem(order),
            ),
          )
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount =>
      controller.selectedRows.where((selected) => selected).length;
}
