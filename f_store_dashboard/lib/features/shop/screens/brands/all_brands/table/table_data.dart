import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/data_table/paginated_data_table.dart';
import 'package:f_store_dashboard/features/shop/controllers/brands_controller/brands_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/brands/all_brands/table/table_source.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandsTable extends StatelessWidget {
  const BrandsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandsController.instance;
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());

      final lgTable = controller.filteredItems.any((element) =>
          element.brandCategories != null &&
          element.brandCategories!.length > 2);
      return FPaginatedDataTable(
        minWidth: 700,
        tableHeight: lgTable ? 96 * 11.5 : 760,
        dataRowHeight: lgTable ? 96 : 64,
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        columns: [
          DataColumn2(
            label: const Text('Brand'),
            fixedWidth: FDeviceUtils.isMobileScreen(context) ? null : 200,
            onSort: (columnIndex, ascending) =>
                controller.sortByName(columnIndex, ascending),
          ),
          const DataColumn2(label: Text('Categories')),
          DataColumn2(
              label: const Text('Feature'),
              fixedWidth: FDeviceUtils.isMobileScreen(context) ? null : 100),
          DataColumn2(
              label: const Text('Date'),
              fixedWidth: FDeviceUtils.isMobileScreen(context) ? null : 200),
          DataColumn2(
              label: const Text('Action'),
              fixedWidth: FDeviceUtils.isMobileScreen(context) ? null : 100)
        ],
        source: TableSource(),
      );
    });
  }
}
