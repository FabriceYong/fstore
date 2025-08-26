import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/shop/controllers/customer_controller/customer_controller.dart';
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

class CustomerRows extends DataTableSource {
  final controller = Get.put(CustomerController());

  @override
  DataRow? getRow(int index) {
    final customer = controller.filteredItems[index];
    return DataRow2(
      onTap: () => Get.toNamed(FRoutes.customerDetails, arguments: customer, parameters: {'customerId': customer.id ?? ''}),
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
      DataCell(
        Row(
          children: [
            FRoundedImage(
              imageType: customer.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
              width: 50,
              height: 50,
              imageUrl:customer.profilePicture.isNotEmpty ? customer.profilePicture : FImages.defaultImageIcon,
              borderRadius: FSizes.borderRadiusMd,
              backgroundColor: FHelperFunctions.isDarkMode(Get.context!)
                  ? FColors.dark
                  : FColors.primaryBackground,
            ),
            const Gap(FSizes.spaceBtwItems),
            Expanded(
                child: Text(
              customer.fullName,
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyLarge!
                  .apply(color: FColors.primary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ))
          ],
        ),
      ),
       DataCell(Text(customer.email)),
       DataCell(Text(customer.phoneNumber)),
      DataCell(Text(customer.createdAt == null ? '' : customer.formattedCreatedAtDate)),
      DataCell(FTableActionButtons(
        view: true,
        edit: false,
        onViewPressed: () =>
            Get.toNamed(FRoutes.customerDetails, arguments: customer, parameters: {'customerId': customer.id ?? ''}),
        onDeletePressed: () => controller.confirmDeleteItem(customer),
      ))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
}
