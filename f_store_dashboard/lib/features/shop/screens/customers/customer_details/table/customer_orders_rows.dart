import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/shop/models/order_model/order_model.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerOrdersRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    final order = OrderModel(
        id: 'id',
        status: OrderStatus.shipped,
        totalAmount: 2500,
        orderDate: DateTime.now(),
        items: []);
    const totalAmount = '2700';
    return DataRow2(
        selected: false,
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
          const DataCell(Text('${5} Items')),
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
          DataCell(Text('${order.totalAmount}'))
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 8;

  @override
  int get selectedRowCount => 0;
}
