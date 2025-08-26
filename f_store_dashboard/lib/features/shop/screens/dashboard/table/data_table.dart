import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/data_table/paginated_data_table.dart';
import 'package:f_store_dashboard/features/shop/controllers/order_controller/order_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/dashboard/table/table_source.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardOrderTable extends StatelessWidget {
  const DashboardOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());

    return Obx(() {
      Visibility(
          visible: false, child: Text(controller.filteredItems.toString()));
      Visibility(
        visible: false,
        child: Text(controller.selectedRows.toString()),
      );
      return FPaginatedDataTable(
        minWidth: 700,
        tableHeight: 500,
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        dataRowHeight: FSizes.xl * 1.2,
        columns: [
          DataColumn2(
              label: const Text('Order ID'),
              onSort: (columnIndex, ascending) =>
                  controller.sortOrderById(columnIndex, ascending)),
          const DataColumn2(label: Text('Data')),
          const DataColumn2(label: Text('Items')),
          DataColumn2(
              label: const Text('Status'),
              fixedWidth: FDeviceUtils.isMobileScreen(context) ? 120 : null),
          const DataColumn2(label: Text('Amount')),
        ],
        source: OrderRows(),
      );
    });
  }
}
