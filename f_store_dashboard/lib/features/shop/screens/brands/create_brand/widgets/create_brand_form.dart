import 'package:f_store_dashboard/common/widgets/chips/choice_chip.dart';
import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/image_uploader.dart';
import 'package:f_store_dashboard/features/shop/controllers/brands_controller/create_brand_controller.dart';
import 'package:f_store_dashboard/features/shop/controllers/category_controller/category_controller.dart';
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

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateBrandController.instance;
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
                'Create New Brand',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Gap(FSizes.spaceBtwSections),

              // Form field
              TextFormField(
                validator: (value) =>
                    FValidator.validateEmptyText('Brand Name', value),
                controller: controller.name,
                decoration: const InputDecoration(
                    labelText: 'Brand Name', prefixIcon: Icon(Iconsax.box)),
              ),
              const Gap(FSizes.spaceBtwInputFields),

              Text(
                'Select Categories',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Gap(FSizes.spaceBtwInputFields / 2),

              Obx(() {
                return Wrap(
                    spacing: FSizes.sm,
                    children: categoryController.allItems
                        .map(
                          (category) => Padding(
                            padding: const EdgeInsets.only(bottom: FSizes.sm),
                            child: FChoiceChip(
                                key: ValueKey(category),
                                text: category.name,
                                selected: controller.selectedCategories
                                    .contains(category),
                                onSelected: (value) =>
                                    controller.toggleSelection(category)),
                          ),
                        )
                        .toList());
              }),
              const Gap(FSizes.spaceBtwInputFields * 2),
              Obx(
                () => FImageUploader(
                  imageType: controller.imageUrl.value.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  width: 80,
                  height: 80,
                  imageUrl: controller.imageUrl.value.isNotEmpty
                      ? controller.imageUrl.value
                      : FImages.defaultImageIcon,
                  onIconButtonPressed: () => controller.pickImage(),
                ),
              ),
              const Gap(FSizes.spaceBtwInputFields),

              Obx(
                () => CheckboxMenuButton(
                    value: controller.isFeatured.value,
                    onChanged: (value) =>
                        controller.isFeatured.value = value ?? false,
                    child: const Text('Featured')),
              ),
              const Gap(FSizes.spaceBtwInputFields * 2),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.createBrand(),
                    child: const Text('Create')),
              ),
              const Gap(FSizes.spaceBtwInputFields * 2)
            ],
          )),
    );
  }
}
