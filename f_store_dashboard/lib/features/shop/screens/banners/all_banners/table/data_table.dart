import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/data_table/paginated_data_table.dart';
import 'package:f_store_dashboard/features/shop/controllers/banners_controller/banner_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/banners/all_banners/table/data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannersTable extends StatelessWidget {
  const BannersTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BannerController.instance;
    return Obx((){
      return FPaginatedDataTable(
        minWidth: 700,
        tableHeight: 900,
        dataRowHeight: 110,
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        columns: [
          const DataColumn2(label: Text('Banner')),
          DataColumn2(
            label: const Text('Redirect Screen'),
            onSort: (columnIndex, ascending) =>
                controller.sortByName(columnIndex, ascending),
          ),
          const DataColumn2(label: Text('Active')),
          const DataColumn2(label: Text('Actions'), fixedWidth: 100),
        ],
        source: BannersRows(),
      );
    }
    );
  }
}
