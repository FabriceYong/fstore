import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/shop/controllers/banners_controller/banner_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/all_categories/widgets/table_action_buttons.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BannersRows extends DataTableSource {
  final controller = BannerController.instance;
  @override
  DataRow? getRow(int index) {
    final banner = controller.filteredItems[index];
    return DataRow2(
        selected: controller.selectedRows[index],
        onTap: () => Get.toNamed(FRoutes.editBanner, arguments: banner, parameters: {'bannerId': banner.id}),
        onSelectChanged: (value) =>
            controller.selectedRows[index] = value ?? false,
        color:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return FHelperFunctions.isDarkMode(Get.context!)
                ? FColors.primary.withOpacity(.2)
                : FColors.primary.withOpacity(.1);
          } else {
            return FHelperFunctions.isDarkMode(Get.context!)
                ? Colors.grey.shade800.withOpacity(.3)
                : Colors.grey.withOpacity(.2);
          }
        }),
        cells: [
          DataCell(
            FRoundedImage(
              width: 180,
              height: 100,
              padding: FSizes.xs,
              imageUrl: banner.imageUrl.isNotEmpty
                  ? banner.imageUrl
                  : FImages.defaultImageIcon,
              imageType: banner.imageUrl.isNotEmpty
                  ? ImageType.network
                  : ImageType.asset,
              borderRadius: FSizes.borderRadiusMd,
              backgroundColor: FHelperFunctions.isDarkMode(Get.context!)
                  ? FColors.black
                  : FColors.primaryBackground,
            ),
          ),
          DataCell(Text(controller.formatRoute(banner.targetScreen))),
          DataCell(banner.active
              ? const Icon(
                  Iconsax.eye,
                  color: FColors.primary,
                )
              : const Icon(Iconsax.eye)),
          banner.createdAt != null
              ? DataCell(Text('Created: ${banner.formattedCreatedAtDate}'))
              : banner.updatedAt != null
                  ? DataCell(Text('Updated: ${banner.formattedUpdatedAtDate}'))
                  : const DataCell(Text('')),
          DataCell(FTableActionButtons(
            onEditPressed: () =>
                Get.toNamed(FRoutes.editBanner, arguments: banner, parameters: {'bannerId': banner.id}),
            onDeletePressed: () => controller.confirmDeleteItem(banner),
          ))
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
