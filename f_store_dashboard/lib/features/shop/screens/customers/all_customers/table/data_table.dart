import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/data_table/paginated_data_table.dart';
import 'package:f_store_dashboard/features/shop/controllers/customer_controller/customer_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/customers/all_customers/table/customer_rows.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomersTable extends StatelessWidget {
  const CustomersTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    return Obx((){
      // UPDATE UI
      Visibility(visible: false, child: Text(controller.filteredItems.length.toString()),); // Show realtime search results
      Visibility(visible: false, child: Text(controller.selectedRows.length.toString()),); // Show realtime selected rows

      return FPaginatedDataTable(
        minWidth: 700,
        sortColumnIndex: controller.sortColumnIndex.value,
        sortAscending: controller.sortAscending.value,
        columns: [
          DataColumn2(
              label: const Text('Customer'),
              onSort: (columnIndex, ascending) =>
                  controller.sortByName(columnIndex, ascending)),
          const DataColumn2(label: Text('Email')),
          const DataColumn2(label: Text('Phone Number')),
          const DataColumn2(label: Text('Registered')),
          const DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: CustomerRows(),
      );
    }
    );
  }
}
