import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/all_categories/widgets/table_action_buttons.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CategoryRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow2(cells: [
      DataCell(Row(
        children: [
          FRoundedImage(
            // imageType: ImageType.network,
            imageType: ImageType.asset,
            width: 50,
            height: 50,
            padding: FSizes.sm,
            // imageUrl: category.image,
            imageUrl: FImages.clothIcon,
            borderRadius: FSizes.borderRadiusMd,
            backgroundColor: FHelperFunctions.isDarkMode(Get.context!)
                ? FColors.darkerGrey
                : FColors.primaryBackground,
          ),
          const Gap(FSizes.spaceBtwItems),
          Expanded(
            child: Text(
              'Name',
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
      const DataCell(Text('Parent')),
      const DataCell(Icon(
        Iconsax.heart5,
        color: FColors.primary,
      )),
      DataCell(Text(DateTime.now().toString())),
      DataCell(
        FTableActionButtons(
            onEditPressed: () =>
                Get.toNamed(FRoutes.editCategory, arguments: 'category'),
            onDeletePressed: () {}),
      )
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 5;

  @override
  int get selectedRowCount => 0;
}