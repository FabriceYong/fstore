import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/loaders/animation_loader.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FPaginatedDataTable extends StatelessWidget {
  const FPaginatedDataTable({
    super.key,
    required this.columns,
    required this.source,
    this.rowsPerPage = 10,
    this.tableHeight = 760,
    this.onPageChanged,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.dataRowHeight = FSizes.xl * 1.7,
    this.minWidth = 1000,
  });

  /// Whether to sort the data table in ascending or descending order
  final bool sortAscending;

  /// Index of the column to sort by
  final int? sortColumnIndex;

  /// Number or rows to display per page
  final int rowsPerPage;

  /// Data source for the data table
  final DataTableSource source;

  /// List of columns for the Data Table
  final List<DataColumn2> columns;

  /// callback function to handle page changes
  final Function(int)? onPageChanged;

  /// Height of each data row in the Data Table
  final double dataRowHeight;

  /// Height of the entire DataTable
  final double tableHeight;

  /// Minimum width of the entire DataTable
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Set the dynamic height of the PaginatedDataTable
      height: tableHeight,
      child: Theme(
        // Used to set the backgroundColor
        data: Theme.of(context).copyWith(
          cardTheme: CardTheme(
              color: FHelperFunctions.isDarkMode(context)
                  ? Colors.black
                  : FColors.white,
              elevation: 0),
        ),
        child: PaginatedDataTable2(
          columns: columns,
          source: source,
          columnSpacing: 10,
          minWidth: minWidth,
          dividerThickness: 0,
          horizontalMargin: 12,
          rowsPerPage: rowsPerPage,
          dataRowHeight: dataRowHeight,

          /// CHECKBOX
          showCheckboxColumn: true,

          /// PAGINATION
          showFirstLastButtons: true,
          onPageChanged: onPageChanged,
          renderEmptyRowsInTheEnd: false,
          onRowsPerPageChanged: (noOfRows) {},

          /// HEADER DESIGN
          headingTextStyle: Theme.of(context).textTheme.titleMedium,
          headingRowColor: WidgetStateProperty.resolveWith(
            (states) => FHelperFunctions.isDarkMode(context)
                ? FColors.dark
                : FColors.grey,
          ),
          empty: const FAnimationLoaderWidget(
            animation: FImages.packageAnimation,
            text: 'Nothing Found',
            height: 200,
            width: 200,
          ),
          headingRowDecoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(FSizes.borderRadiusMd),
              topRight: Radius.circular(FSizes.borderRadiusMd),
            ),
          ),

          /// SORTING
          sortColumnIndex: sortColumnIndex,
          sortAscending: sortAscending,
          sortArrowBuilder: (bool ascending, bool sorted) {
            if (sorted) {
              return Icon(ascending ? Iconsax.arrow_up_3 : Iconsax.arrow_down,
                  size: FSizes.iconSm);
            } else {
              return const Icon(
                Iconsax.arrow_3,
                size: FSizes.iconSm,
              );
            }
          },
        ),
      ),
    );
  }
}
