import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/shop/controllers/category_controller/category_controller.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/edit_product_controller.dart';
import 'package:f_store_dashboard/features/shop/models/category_model/category_model.dart'; // Added this import
import 'package:f_store_dashboard/features/shop/models/product/product_model.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    // Get instance of the category controller
    final categoryController = Get.put(CategoryController());
    final editProductController = Get.put(EditProductController());

    // Fetch categories if the list is empty
    if (categoryController.allItems.isEmpty) {
      categoryController.fetchItems();
    }
    return FRoundedContainer(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.black : FColors.white,
      padding: const EdgeInsets.all(FSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories Label
          Text(
            'Categories',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(FSizes.spaceBtwItems),

          // MultiSelectDialogField for Selecting Categories - Wrapped with Obx
          Obx(() {
            // Show loader while categories are loading
            if (editProductController.selectedCategoriesLoader.value) {
              return const Center(child: CircularProgressIndicator());
            }

            // Show error if category list is empty after loading (optional, depends on desired behavior)
            if (categoryController.allItems.isEmpty) {
              return Center(
                  child: Text('No categories found.',
                      style: Theme.of(context).textTheme.bodyMedium));
            }

            return MultiSelectDialogField(
              buttonText: const Text('Select Categories'),
              title: const Text('Categories'),
              items: categoryController.allItems
                  .map((category) => MultiSelectItem(category, category.name))
                  .toList(),
              listType: MultiSelectListType.CHIP,
              // Set initial value from the controller
              initialValue: editProductController.selectedCategories.toList(),
              onConfirm: (values) {
                // Cast the list to the correct type before assigning
                editProductController.selectedCategories.assignAll(values.cast<CategoryModel>());
              },
              chipDisplay: MultiSelectChipDisplay(
                // Optional: Customize chip appearance
                onTap: (value) {
                  editProductController.selectedCategories.remove(value);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
