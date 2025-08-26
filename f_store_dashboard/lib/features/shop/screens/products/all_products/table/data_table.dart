import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/data_table/paginated_data_table.dart';
import 'package:f_store_dashboard/common/widgets/data_table/table_header.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/product_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/products/all_products/table/data_source.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductsTable extends StatelessWidget {
  const ProductsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final searchController = TextEditingController();
    final filterOptions = ['In Stock', 'Low Stock', 'Out of Stock', 'Featured'];
    final RxString selectedFilter = ''.obs;

    return Column(
      children: [
        // Enhanced Table Header with filtering
        Obx(
          () => FTableHeader(
            buttonText: 'Create New Product',
            onPressed: () => Get.toNamed(FRoutes.createProduct),
            controller: searchController,
            searchOnChanged: (value) => controller.searchItems(value),
            filterOptions: filterOptions,
            selectedFilter:
                selectedFilter.value.isEmpty ? null : selectedFilter.value,
            onFilterSelected: (value) {
              selectedFilter.value = value ?? '';
              // Call the controller method to handle filtering
              controller.filterProducts(value);
            },
            showExportButton: true,
            onExportPressed: () {
              // Show export options dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Export Products'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.file_download,
                            color: FColors.primary),
                        title: const Text('Export as CSV'),
                        onTap: () {
                          Navigator.pop(context);
                          // Implement CSV export functionality
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.picture_as_pdf,
                            color: FColors.primary),
                        title: const Text('Export as PDF'),
                        onTap: () {
                          Navigator.pop(context);
                          // Implement PDF export functionality
                        },
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const Gap(FSizes.spaceBtwItems),

        // Data Table
        Obx(() {
          // The Obx should react to changes in controller.filteredItems, controller.selectedRows,
          // controller.sortAscending, and controller.sortColumnIndex implicitly.
          // No need for the extra Visibility widgets.
          return FPaginatedDataTable(
            minWidth: 1000,
            sortAscending: controller.sortAscending.value,
            sortColumnIndex: controller.sortColumnIndex.value,
            columns: [
              DataColumn2(
                label: const Text('Product'),
                fixedWidth: FDeviceUtils.isDesktopScreen(context) ? 400 : 300,
                onSort: (columnIndex, ascending) =>
                    controller.sortByName(columnIndex, ascending),
              ),
              DataColumn2(
                label: const Text('Stock'),
                onSort: (columnIndex, ascending) =>
                    controller.sortByStock(columnIndex, ascending),
              ),
              DataColumn2(
                label: const Text('Quantity Sold'),
                onSort: (columnIndex, ascending) =>
                    controller.sortBySoldItems(columnIndex, ascending),
              ),
              DataColumn2(
                label: const Text('Brand'),
                onSort: (columnIndex, ascending) =>
                    controller.sortByBrand(columnIndex, ascending),
              ),
              DataColumn2(
                label: const Text('Price'),
                onSort: (columnIndex, ascending) =>
                    controller.sortByPrice(columnIndex, ascending),
              ),
              const DataColumn2(label: Text('Date')),
              const DataColumn2(label: Text('Action'), fixedWidth: 120),
            ],
            source: ProductRows(),
          );
        }),
      ],
    );
  }
}
