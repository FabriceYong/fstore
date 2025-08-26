import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/create_product_controller.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/product_variations_controller.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers
    final createProductController = Get.put(CreateProductController());
    final attributesController = Get.put(ProductAttributesController());
    final variationController = Get.put(ProductVariationsController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => createProductController.productType.value == ProductType.single
              ? const Divider(
                  color: FColors.primaryBackground,
                )
              : const SizedBox.shrink(),
        ),
        const Gap(FSizes.spaceBtwSections),

        Text(
          'Add Product Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Gap(FSizes.spaceBtwItems),

        // Form to Add New Attribute
        Form(
          key: attributesController.attributesFormKey,
          child: FDeviceUtils.isDesktopScreen(context)
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Attribute Name
                    Expanded(child: _buildAttributeName(attributesController)),
                    const Gap(FSizes.spaceBtwItems),
                    // Attribute Value
                    Expanded(
                        flex: 2,
                        child: _buildAttributeTextField(attributesController)),
                    const Gap(FSizes.spaceBtwItems),

                    // Add Attribute Button
                    Expanded(
                        child: _buildAddAttributeButton(attributesController))
                  ],
                )
              : Column(
                  children: [
                    // Attribute Name
                    _buildAttributeName(attributesController),
                    const Gap(FSizes.spaceBtwItems),

                    // Attribute Value
                    _buildAttributeTextField(attributesController),
                    const Gap(FSizes.spaceBtwItems),

                    // Add Attribute Button
                    _buildAddAttributeButton(attributesController)
                  ],
                ),
        ),
        const Gap(FSizes.spaceBtwSections),

        // List of Added Attributes
        Text(
          'All Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Gap(FSizes.spaceBtwItems),

        // Display added attributes in a Rounded Container
        FRoundedContainer(
          backgroundColor: FHelperFunctions.isDarkMode(context)
              ? FColors.dark
              : FColors.primaryBackground,
          padding: const EdgeInsets.all(FSizes.md),
          child: Column(
            children: [
              Obx(() => attributesController.productAttributes.isNotEmpty
                  ? buildAttributesList(context, attributesController)
                  : buildEmptyAttribute()),
            ],
          ),
        ),
        const Gap(FSizes.spaceBtwSections),

        Obx(
          () => createProductController.productType.value ==
                      ProductType.variable &&
                  variationController.productVariations.isEmpty
              ? Center(
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton.icon(
                      onPressed: () => variationController.generateVariationsConfirmation(context),
                      label: const Text('Generate Variations'),
                      icon: const Icon(Iconsax.activity),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        )
      ],
    );
  }

  // Build TextFormField for Attribute Name
  TextFormField _buildAttributeName(
      ProductAttributesController attributeController) {
    return TextFormField(
      controller: attributeController.attributeName,
      validator: (value) =>
          FValidator.validateEmptyText('Attribute Name', value),
      decoration: const InputDecoration(
          labelText: 'Attribute Text', hintText: 'Color, Sizes, Material'),
    );
  }

// Build TextFormField for attribute values
  SizedBox _buildAttributeTextField(
      ProductAttributesController attributeController) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        controller: attributeController.attributes,
        expands: true,
        maxLines: null,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator: (value) =>
            FValidator.validateEmptyText('Attributes Field', value),
        decoration: const InputDecoration(
            labelText: 'Attributes',
            hintText:
                'Add Attributes Separated By | Example: Green | Blue | Yellow'),
      ),
    );
  }

  // Build Add Button to add attribute
  SizedBox _buildAddAttributeButton(ProductAttributesController controller) {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        icon: const Icon(Iconsax.add),
        onPressed: () => controller.addNewAttribute(),
        label: const Text('Add'),
        style: ElevatedButton.styleFrom(
          foregroundColor: FColors.black,
          backgroundColor: FColors.secondary,
          side: const BorderSide(color: FColors.secondary),
        ),
      ),
    );
  }

  ListView buildAttributesList(
      BuildContext context, ProductAttributesController attributesController) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: attributesController.productAttributes.length,
      separatorBuilder: (_, __) => const Gap(FSizes.spaceBtwItems),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: FHelperFunctions.isDarkMode(context)
                ? FColors.black
                : FColors.white,
            borderRadius: BorderRadius.circular(FSizes.borderRadiusLg),
          ),
          child: ListTile(
            title:
                Text(attributesController.productAttributes[index].name ?? ''),
            subtitle: Text(attributesController.productAttributes[index].values!
                .map((e) => e.trim())
                .toString()),
            trailing: IconButton(
              onPressed: () =>
                  attributesController.removeAttribute(index, context),
              icon: const Icon(
                Iconsax.trash,
                color: FColors.error,
              ),
            ),
          ),
        );
      },
    );
  }

  Column buildEmptyAttribute() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FRoundedImage(
              imageType: ImageType.asset,
              width: 150,
              height: 80,
              imageUrl: FImages.defaultAttributeColorsImageIcon,
            ),
          ],
        ),
        Gap(FSizes.spaceBtwItems),
        Text('There are no attributes added for this product')
      ],
    );
  }
}
