import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/data_table/paginated_data_table.dart';
import 'package:f_store_dashboard/features/shop/screens/brands/all_brands/table/table_source.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class BrandsTable extends StatelessWidget {
  const BrandsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return FPaginatedDataTable(
      minWidth: 700,
      tableHeight: 760,
      dataRowHeight: 64,
      columns: [
        DataColumn2(
            label: const Text('Brand'),
            fixedWidth: FDeviceUtils.isMobileScreen(context) ? null : 200),
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
  }
}
