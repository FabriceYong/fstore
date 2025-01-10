import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/all_categories/widgets/table_action_buttons.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TableSource extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              FRoundedImage(
                imageType: ImageType.asset,
                width: 50,
                height: 50,
                padding: FSizes.sm,
                imageUrl: FImages.ikeaLogo,
                borderRadius: FSizes.borderRadiusMd,
                backgroundColor: FHelperFunctions.isDarkMode(Get.context!)
                    ? FColors.darkerGrey
                    : FColors.primaryBackground,
              ),
              const Gap(FSizes.spaceBtwItems),
              Text(
                'IKEA',
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodyLarge!
                    .apply(color: FColors.primary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: FDeviceUtils.isMobileScreen(Get.context!)
                            ? 0
                            : FSizes.sm),
                    child: const Chip(
                      label: Text('Bedroom Lamp'),
                      padding: EdgeInsets.all(FSizes.xs),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: FDeviceUtils.isMobileScreen(Get.context!)
                            ? 0
                            : FSizes.sm),
                    child: const Chip(
                      label: Text('Bedroom Table'),
                      padding: EdgeInsets.all(FSizes.xs),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: FDeviceUtils.isMobileScreen(Get.context!)
                            ? 0
                            : FSizes.sm),
                    child: const Chip(
                      label: Text('Bedroom Chair'),
                      padding: EdgeInsets.all(FSizes.xs),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const DataCell(Icon(
          Iconsax.heart5,
          color: FColors.primary,
        )),
        DataCell(Text(DateTime.now().toString())),
        DataCell(FTableActionButtons(
          onEditPressed: () => Get.toNamed(FRoutes.editBrand, arguments: ''),
          onDeletePressed: () {},
        ))
      ],
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => 20;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
