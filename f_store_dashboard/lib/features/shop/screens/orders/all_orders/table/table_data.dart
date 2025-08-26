import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/data_table/paginated_data_table.dart';
import 'package:f_store_dashboard/features/shop/controllers/order_controller/order_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/orders/all_orders/table/data_source.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersTable extends StatelessWidget {
  const OrdersTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Obx((){
      Visibility(visible: false, child: Text(controller.filteredItems.length.toString()),);
      Visibility(visible: false, child: Text(controller.selectedRows.length.toString()),);

      return  FPaginatedDataTable(
        minWidth: 700,
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        columns: [
          const DataColumn2(label: Text('Order ID')),
           DataColumn2(label: const Text('Date'), onSort: (columnIndex, ascending) => controller.sortOrderByDate(columnIndex, ascending)),
          const DataColumn2(label: Text('Items')),
          DataColumn2(
              label: const Text('Status'),
              fixedWidth: FDeviceUtils.isMobileScreen(context) ? 120 : null),
          const DataColumn2(label: Text('Amount')),
          const DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: OrderTableRows(),
      );
    }
    );
  }
}
