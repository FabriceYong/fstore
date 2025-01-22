import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/data_table/paginated_data_table.dart';
import 'package:f_store_dashboard/features/shop/screens/customers/all_customers/table/customer_rows.dart';
import 'package:flutter/material.dart';

class CustomersTable extends StatelessWidget {
  const CustomersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return FPaginatedDataTable(
      minWidth: 700,
      columns: const [
        DataColumn2(label: Text('Customer')),
        DataColumn2(label: Text('Email')),
        DataColumn2(label: Text('Phone Number')),
        DataColumn2(label: Text('Registered')),
        DataColumn2(label: Text('Action'), fixedWidth: 100),
      ],
      source: CustomerRows(),
    );
  }
}
