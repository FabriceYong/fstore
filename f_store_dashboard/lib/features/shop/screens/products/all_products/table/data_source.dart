import 'package:data_table_2/data_table_2.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/product_controller.dart';
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

class ProductRows extends DataTableSource {
  final controller = ProductController.instance;
  
  @override
  DataRow? getRow(int index) {
    final product = controller.filteredItems[index];
    final productStockTotal = controller.getProductStockTotal(product); // Call once
    final stockCount = int.tryParse(productStockTotal) ?? 0;
    final isDarkMode = FHelperFunctions.isDarkMode(Get.context!);
    
    // Determine stock status color
    Color stockColor = FColors.success;
    if (stockCount <= 5) {
      stockColor = FColors.error;
    } else if (stockCount <= 20) {
      stockColor = FColors.warning;
    }

    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) =>
          controller.selectedRows[index] = value ?? false,
      onTap: () => Get.toNamed(FRoutes.editProduct, arguments: product, parameters: {'productId': product.id.toString()}),
      color: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return isDarkMode 
                ? FColors.primary.withOpacity(0.2) 
                : FColors.primary.withOpacity(0.1);
          }
          if (states.contains(WidgetState.hovered)) {
            return isDarkMode 
                ? Colors.grey.shade800 
                : FColors.grey.withOpacity(0.3);
          }
          return null;
        },
      ),
      cells: [
        DataCell(
          Row(
            children: [
              Stack(
                children: [
                  FRoundedImage(
                    imageType: product.thumbnail.isEmpty
                        ? ImageType.asset
                        : ImageType.network,
                    width: 50,
                    height: 50,
                    padding: FSizes.xs,
                    imageUrl: product.thumbnail.isEmpty
                        ? FImages.defaultImageIcon
                        : product.thumbnail,
                    borderRadius: FSizes.borderRadiusMd,
                    backgroundColor: isDarkMode
                        ? FColors.black
                        : FColors.primaryBackground,
                  ),
                  if (product.isFeatured == true)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: FColors.primary,
                          borderRadius: BorderRadius.circular(FSizes.borderRadiusSm),
                        ),
                        child: const Icon(
                          Iconsax.star1,
                          size: 12,
                          color: FColors.white,
                        ),
                      ),
                    ),
                ],
              ),
              const Gap(FSizes.spaceBtwItems),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      product.title,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .bodyLarge!
                          .apply(color: FColors.primary, fontWeightDelta: 1),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (product.sku != null && product.sku!.isNotEmpty)
                      Text(
                        'SKU: ${product.sku}',
                        style: Theme.of(Get.context!).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              )
            ],
          ),
        ),

        // Stock
        DataCell(
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: stockColor,
                  shape: BoxShape.circle,
                ),
              ),
              const Gap(FSizes.xs),
              Text(
                productStockTotal, // Use stored value
                style: TextStyle(
                  color: stockColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        
        // Sold Quantity
        DataCell(
          Text(
            controller.getProductsSoldQuantity(product),
            style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          )
        ),

        // Brand
        DataCell(
          Row(
            children: [
              FRoundedImage(
                imageType: product.brand != null
                    ? ImageType.network
                    : ImageType.asset,
                width: 35,
                height: 35,
                padding: FSizes.xs,
                imageUrl: product.brand != null
                    ? product.brand!.image
                    : FImages.defaultImageIcon,
                borderRadius: FSizes.borderRadiusMd,
                backgroundColor: isDarkMode
                    ? FColors.black
                    : FColors.primaryBackground,
              ),
              const Gap(FSizes.spaceBtwItems),
              Flexible(
                child: Text(
                  product.brand != null ? product.brand!.name : '',
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodyMedium!
                      .apply(fontWeightDelta: 1),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),

        // Price
        DataCell(
          Text(
            // Formatting (e.g., adding currency symbols) should ideally be done here using a NumberFormat utility.
            controller.getProductPrice(product), 
            style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: FColors.primary,
            ),
          )
        ),

        //Date
        DataCell(
          Text(
            product.formattedDate ?? '',
            style: Theme.of(Get.context!).textTheme.bodyMedium,
          )
        ),

        // Action Buttons
        DataCell(
          FTableActionButtons(
            onEditPressed: () => Get.toNamed(
              FRoutes.editProduct,
              arguments: product,
              parameters: {'productId': product.id.toString()}
            ),
            onDeletePressed: () => controller.confirmDeleteItem(product),
          ),
        )
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
