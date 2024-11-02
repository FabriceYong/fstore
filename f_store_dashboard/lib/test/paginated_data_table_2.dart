import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/data_table/paginated_data_table.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    final controller = Get.put(DashboardController());
    return Scaffold(
      backgroundColor: dark ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              /// Search
              TextFormField(
                controller: controller.searchTextController,
                onChanged: (query) => controller.searchQuery(query),
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Iconsax.search_normal),
                ),
              ),
              const Gap(FSizes.spaceBtwSections),
              Obx(
                () {
                  /// Orders & Selected Rows are Hidden => Just to update the UI => Obx => [ProductRows]
                  Visibility(
                    visible: false,
                    child: Text(controller.filteredDataList.length.toString()),
                  );

                  return FPaginatedDataTable(
                    onPageChanged: (value) {},

                    /// SORTING
                    sortAscending: controller.sortAscending.value,
                    sortColumnIndex: controller.sortColumnIndex.value,
                    columns: [
                      const DataColumn2(label: Text('Column 1')),
                      DataColumn2(
                          label: const Text('Column 2'),
                          onSort: (columnIndex, ascending) => columnIndex =
                              controller.sortById(columnIndex, ascending)),
                      const DataColumn2(label: Text('Column 3')),
                      DataColumn2(
                          label: const Text('Column 4'),
                          onSort: (columnIndex, ascending) =>
                              controller.sortById(columnIndex, ascending)),
                    ],
                    source: MyData(controller: controller),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  final DashboardController controller;

  MyData({required this.controller});

  @override
  DataRow? getRow(int index) {
    final data = controller.filteredDataList[index];

    return DataRow2(
        onTap: () {},
        selected: controller.selectedRows[index],
        onSelectChanged: (value) =>
            controller.selectedRows[index] = value ?? false,
        cells: [
          DataCell(Text(data['Column1'] ?? '')),
          DataCell(Text(data['Column2'] ?? '')),
          DataCell(Text(data['Column3'] ?? '')),
          DataCell(Text(data['Column4'] ?? '')),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredDataList.length;

  @override
  int get selectedRowCount => 0;
}

class DashboardController extends GetxController {
  var dataList = <Map<String, dynamic>>[].obs;
  var filteredDataList = <Map<String, dynamic>>[].obs;
  RxList<bool> selectedRows =
      <bool>[].obs; // Observable list to store selected rows
  RxInt sortColumnIndex = 1
      .obs; // Observable value for tracking the index of the column for sorting
  RxBool sortAscending = true
      .obs; // Observable value for tracking the sorting order (ascending or descending)
  final searchTextController =
      TextEditingController(); // Controller for handling search text input

  @override
  void onInit() {
    fetchDummyData();
    super.onInit();
  }

  searchQuery(String query) {
    filteredDataList.assignAll(dataList
        .where((item) => item['Column1']!.contains(query.toLowerCase())));
  }

  sortById(int sortColumnIndex, bool ascending) {
    sortAscending.value = ascending;
    filteredDataList.sort((a, b) {
      if (ascending) {
        return a['Column1']
            .toString()
            .toLowerCase()
            .compareTo(b['column1'].toString().toLowerCase());
      } else {
        return a['Column1']
            .toString()
            .toLowerCase()
            .compareTo(b['Column1'].toString().toLowerCase());
      }
    });
    this.sortColumnIndex.value = sortColumnIndex;
  }

  fetchDummyData() {
    selectedRows.assignAll(
        List.generate(36, (int index) => false)); // Initialize selected Rows

    // Data List
    dataList.addAll(
      List.generate(
        36,
        (index) => {
          'Column1': 'Data ${index + 1} - 1',
          'Column2': 'Data ${index + 1} - 2',
          'Column3': 'Data ${index + 1} - 3',
          'Column4': 'Data ${index + 1} - 4',
        },
      ),
    );

    // Filtered Data List
    filteredDataList.addAll(
      List.generate(
        36,
        (index) => {
          'Column1': 'Data ${index + 1} - 1',
          'Column2': 'Data ${index + 1} - 2',
          'Column3': 'Data ${index + 1} - 3',
          'Column4': 'Data ${index + 1} - 4',
        },
      ),
    );
  }
}
