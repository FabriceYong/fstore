import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/data_table/paginated_data_table.dart';
import 'package:f_store_dashboard/features/shop/screens/products/all_products/table/data_source.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class ProductsTable extends StatelessWidget {
  const ProductsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return FPaginatedDataTable(
      minWidth: 1000,
      columns: [
        DataColumn2(
            label: const Text('Product'),
            fixedWidth: FDeviceUtils.isDesktopScreen(context) ? 400 : 300),
        const DataColumn2(label: Text('Stock')),
        const DataColumn2(label: Text('Brand')),
        const DataColumn2(label: Text('Price')),
        const DataColumn2(label: Text('Date')),
        const DataColumn2(label: Text('Action'), fixedWidth: 100),
      ],
      source: ProductRows(),
    );
  }
}
