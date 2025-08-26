import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/shop/controllers/category_controller/category_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/all_categories/widgets/table_action_buttons.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CategoryRows extends DataTableSource {
  final controller = CategoryController.instance;
  @override
  DataRow? getRow(int index) {
    final category = controller.filteredItems[index];
    final parentCategory = controller.allItems
        .firstWhereOrNull((item) => item.id == category.parentId);
    return DataRow2(
        selected: controller.selectedRows[index],
        onSelectChanged: (value) =>
            controller.selectedRows[index] = value ?? false,
        onTap: () => Get.toNamed(FRoutes.editCategory,
            arguments: category, parameters: {'categoryId': category.id}),
        color:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return FHelperFunctions.isDarkMode(Get.context!)
                ? FColors.primary.withOpacity(.3) : FColors.primary.withOpacity(1);    
          }else {
            return FHelperFunctions.isDarkMode(Get.context!) ? Colors.grey.shade800.withOpacity(.3)
                    : Colors.grey.withOpacity(.2);
          }
        }), 
        cells: [
          DataCell(Row(
            children: [
              FRoundedImage(
                // imageType: ImageType.network,
                imageType: ImageType.network,
                width: 50,
                height: 50,
                padding: FSizes.sm,
                imageUrl: category.image,
                borderRadius: FSizes.borderRadiusMd,
                backgroundColor: FHelperFunctions.isDarkMode(Get.context!)
                    ? FColors.darkerGrey
                    : FColors.primaryBackground,
              ),
              const Gap(FSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  category.name,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodyLarge!
                      .apply(color: FColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          )),
          DataCell(Text(parentCategory != null ? parentCategory.name : '')),
          DataCell(category.isFeatured
              ? const Icon(
                  Iconsax.heart5,
                  color: FColors.primary,
                )
              : const Icon(Iconsax.heart)),
          category.createdAt != null
              ? DataCell(Text('Created: ${category.formattedCreatedAtDate}'))
              : category.updatedAt != null
                  ? DataCell(Text('Updated: ${category.formattedUpdatedAt}'))
                  : const DataCell(Text('')),
          DataCell(
            FTableActionButtons(
                onEditPressed: () =>
                    Get.toNamed(FRoutes.editCategory, arguments: category),
                onDeletePressed: () => controller.confirmDeleteItem(category)),
          )
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount =>
      controller.selectedRows.where((selected) => selected).length;
}
