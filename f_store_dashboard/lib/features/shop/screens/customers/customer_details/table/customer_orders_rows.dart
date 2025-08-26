import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/shop/controllers/customer_controller/customer_details_controller.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerOrdersRows extends DataTableSource {
  final controller = CustomerDetailsController.instance;
  @override
  DataRow? getRow(int index) {
    final order = controller.filteredCustomerOrders[index];
    final totalAmount = order.items.fold<double>(
        0.0, (previousValue, element) => previousValue + element.price);
    return DataRow2(
        selected: controller.selectedRows[index],
        onTap: () => Get.toNamed(FRoutes.orderDetails, arguments: order),
        cells: [
          // Order Id
          DataCell(
            Text(
              order.id,
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyLarge!
                  .apply(color: FColors.primary),
            ),
          ),
          // Order Date
          DataCell(Text(order.formattedOrderDate)),
          // Number of Items
          DataCell(Text('${order.items.length} Items')),
          // Order Status
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

          // Total Amount
          DataCell(Text(totalAmount.toString()))
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredCustomerOrders.length;

  @override
  int get selectedRowCount =>
      controller.selectedRows.where((selected) => selected).length;
}
