import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/shop/models/product_model/product_model.dart';
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

class ProductRows extends DataTableSource {
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
                  padding: FSizes.xs,
                  imageUrl: FImages.productImage29,
                  borderRadius: FSizes.borderRadiusMd,
                  backgroundColor: FHelperFunctions.isDarkMode(Get.context!)
                      ? FColors.black
                      : FColors.primaryBackground),
              const Gap(FSizes.spaceBtwItems),
              Flexible(
                  child: Text('Product Title',
                      style: Theme.of(Get.context!)
                          .textTheme
                          .bodyLarge!
                          .apply(color: FColors.primary),
                      overflow: TextOverflow.ellipsis))
            ],
          ),
        ),

        // Stock
        const DataCell(Text('256')),

        // Brand
        DataCell(
          Row(
            children: [
              FRoundedImage(
                  imageType: ImageType.asset,
                  width: 35,
                  height: 35,
                  padding: FSizes.xs,
                  imageUrl: FImages.adidasLogo,
                  borderRadius: FSizes.borderRadiusMd,
                  backgroundColor: FHelperFunctions.isDarkMode(Get.context!)
                      ? FColors.black
                      : FColors.primaryBackground),
              const Gap(FSizes.spaceBtwItems),
              Flexible(
                  child: Text('Adidas',
                      style: Theme.of(Get.context!)
                          .textTheme
                          .bodyLarge!
                          .apply(color: FColors.primary),
                      overflow: TextOverflow.ellipsis))
            ],
          ),
        ),

        // Price
        const DataCell(Text('\$359')),

        //Date
        DataCell(Text(DateTime.now().toString())),

        // Action Buttons
        DataCell(
          FTableActionButtons(
            onEditPressed: () => Get.toNamed(
              FRoutes.editProduct,
              arguments: ProductModel.empty(),
            ),
            onDeletePressed: (){}
          ),
        )
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}
