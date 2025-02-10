import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/data_table/paginated_data_table.dart';
import 'package:f_store_dashboard/features/shop/controllers/category_controller/category_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/all_categories/table/table_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesTable extends StatelessWidget {
  const CategoriesTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Obx(() {
      Text(controller.filteredItems.length
          .toString()); // To change the state of the search field so search results can be shown
      Text(controller.selectedRows.length
          .toString()); // To change the state of the selected rows so the selected rows can be shown

      return FPaginatedDataTable(
        minWidth: 700,
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        columns: [
          DataColumn2(
              label: const Text('Category'),
              onSort: (columnIndex, ascending) =>
                  controller.sortByName(columnIndex, ascending)),
          DataColumn2(
              label: const Text('Parent Category'),
              onSort: (columnIndex, ascending) =>
                  controller.sortByParentName(columnIndex, ascending)),
          const DataColumn2(label: Text('Featured')),
          const DataColumn2(label: Text('Date')),
          const DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: CategoryRows(),
      );
    });
  }
}
