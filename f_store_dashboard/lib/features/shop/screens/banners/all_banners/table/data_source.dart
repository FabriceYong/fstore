import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/shop/models/banner_model/banner_model.dart';
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
  @override
  DataRow? getRow(int index) {
    return DataRow2(cells: [
      DataCell(
        FRoundedImage(
          width: 180,
          height: 100,
          padding: FSizes.xs,
          imageUrl: FImages.banner1,
          imageType: ImageType.asset,
          borderRadius: FSizes.borderRadiusMd,
          backgroundColor: FHelperFunctions.isDarkMode(Get.context!)
              ? FColors.black
              : FColors.primaryBackground,
        ),
      ),
      const DataCell(Text('Shop')),
      const DataCell(Icon(
        Iconsax.eye,
        color: FColors.primary,
      )),
      DataCell(FTableActionButtons(
        onEditPressed: () => Get.toNamed(FRoutes.editBanner,
            arguments: BannerModel(active: '', targetUrl: '', imageUrl: '')),
        onDeletePressed: () {},
      ))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 20;

  @override
  int get selectedRowCount => 0;
}
