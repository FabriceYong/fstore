import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/image_uploader.dart';
import 'package:f_store_dashboard/common/widgets/schimmers/shimmer_effect.dart';
import 'package:f_store_dashboard/features/shop/controllers/category_controller/category_controller.dart';
import 'package:f_store_dashboard/features/shop/controllers/category_controller/create_category_controller.dart';
import 'package:f_store_dashboard/features/shop/models/category_model/category_model.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateCategoryController());
    final categoryController = Get.put(CategoryController());
    return FRoundedContainer(
      width: 500,
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.dark : Colors.white,
      padding: const EdgeInsets.all(FSizes.defaultSpace),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const Gap(FSizes.sm),
            Text(
              'Create New Category',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const Gap(FSizes.spaceBtwInputFields * 2),
            TextFormField(
              controller: controller.name,
              validator: (value) => FValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                labelText: 'Category Name',
                prefixIcon: Icon(Iconsax.category),
              ),
            ),

            const Gap(FSizes.spaceBtwInputFields),
            Obx(
              () => categoryController.isLoading.value
                  ? const FShimmerEffect(width: double.infinity, height: 55)
                  : DropdownButtonFormField<CategoryModel>(
                      decoration: const InputDecoration(
                          labelText: 'Parent Category',
                          hintText: 'Parent Category',
                          prefixIcon: Icon(Iconsax.bezier)),
                      value:
                          controller.selectedParentCategory.value.id.isNotEmpty
                              ? controller.selectedParentCategory.value
                              : null,
                      items: categoryController.allCategories
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [Text(category.name)],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (CategoryModel? newValue) => controller
                          .selectedParentCategory
                          .value = newValue ?? CategoryModel.empty(),
                    ),
            ),

            const Gap(FSizes.spaceBtwSections),
            Obx(
              () => FImageUploader(
                  width: 80,
                  height: 80,
                  imageUrl: controller.imageUrl.value.isNotEmpty
                      ? controller.imageUrl.value
                      : FImages.defaultImageIcon,
                  imageType: controller.imageUrl.value.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  onIconButtonPressed: () => controller.pickImage()),
            ),

            const Gap(FSizes.spaceBtwSections),

            Obx(
              () => CheckboxMenuButton(
                value: controller.isFeatured.value,
                onChanged: (value) =>
                    controller.isFeatured.value = value ?? false,
                child: const Text('Featured'),
              ),
            ),
            const Gap(FSizes.spaceBtwInputFields),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.createNewCategory(),
                  child: const Text('Create')),
            ),

            const Gap(FSizes.spaceBtwInputFields)
          ],
        ),
      ),
    );
  }
}
