import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/data_table/paginated_data_table.dart';
import 'package:f_store_dashboard/features/shop/screens/customers/customer_details/table/customer_orders_rows.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class CustomerOrdersTable extends StatelessWidget {
  const CustomerOrdersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return FPaginatedDataTable(
      minWidth: 550,
      tableHeight: 640,
      dataRowHeight: kMinInteractiveDimension,
      columns: [
        const DataColumn2(label: Text('Order Id')),
        const DataColumn2(label: Text('Date')),
        const DataColumn2(label: Text('Items')),
        DataColumn2(
            label: const Text('Status'),
            fixedWidth: FDeviceUtils.isMobileScreen(context) ? 100 : null),
        const DataColumn2(label: Text('Amount'), numeric: true),
      ],
      source: CustomerOrdersRows(),
    );
  }
}
