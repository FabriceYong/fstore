import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/shop/controllers/brands_controller/brands_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/all_categories/widgets/table_action_buttons.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TableSource extends DataTableSource {
  final controller = BrandsController.instance;
  @override
  DataRow? getRow(int index) {
    final brand = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) =>
          controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              FRoundedImage(
                imageType: ImageType.network,
                width: 50,
                height: 50,
                padding: FSizes.sm,
                imageUrl: brand.image,
                borderRadius: FSizes.borderRadiusMd,
                backgroundColor: FHelperFunctions.isDarkMode(Get.context!)
                    ? FColors.darkerGrey
                    : FColors.primaryBackground,
              ),
              const Gap(FSizes.spaceBtwItems),
              Flexible(
                child: Text(
                  brand.name,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodyLarge!
                      .apply(color: FColors.primary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: FSizes.sm),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                spacing: FSizes.xs,
                direction: FDeviceUtils.isMobileScreen(Get.context!)
                    ? Axis.vertical
                    : Axis.horizontal,
                children: brand.brandCategories != null
                    ? brand.brandCategories!
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    FDeviceUtils.isMobileScreen(Get.context!)
                                        ? 0
                                        : FSizes.xs),
                            child: Chip(
                              label: Text(e.name),
                              padding: const EdgeInsets.all(FSizes.xs),
                            ),
                          ),
                        )
                        .toList()
                    : [const SizedBox()],
              ),
            ),
          ),
        ),
        DataCell(brand.isFeatured
            ? const Icon(
                Iconsax.heart5,
                color: FColors.primary,
              )
            : const Icon(Iconsax.heart)),
        brand.createdAt != null
            ? DataCell(Text('Created: ${brand.formattedCreatedAtDate}'))
            : brand.updatedAt != null
                ? DataCell(Text('Updated: ${brand.formattedUpdatedAtDate}'))
                : const DataCell(Text('')),
        DataCell(FTableActionButtons(
          onEditPressed: () => Get.toNamed(FRoutes.editBrand, arguments: brand),
          onDeletePressed: () => controller.confirmDeleteItem(brand),
        ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount =>
      controller.selectedRows.where((selected) => selected).length;
}
