import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/image_uploader.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/edit_product_controller.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/product_images_controller.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/product_variations_controller.dart';
import 'package:f_store_dashboard/features/shop/models/product/product_variations_model.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductVariationsController());
    return Obx(
      () => EditProductController.instance.productType.value ==
              ProductType.variable
          ? FRoundedContainer(
              backgroundColor: FHelperFunctions.isDarkMode(context)
                  ? FColors.dark
                  : FColors.white,
              padding: const EdgeInsets.all(FSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Variations',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextButton(
                          onPressed: () => controller.removeVariations(context),
                          child: const Text('Remove Variations')),
                    ],
                  ),
                  const Gap(FSizes.spaceBtwItems),

                  // Variations List
                  if (controller.productVariations.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: controller.productVariations.length,
                      separatorBuilder: (_, __) =>
                          const Gap(FSizes.spaceBtwItems),
                      itemBuilder: (context, index) {
                        final variation = controller.productVariations[index];
                        return _buildVariationTile(
                            context, index, variation, controller);
                      },
                    )
                  else
                    // No Variation Message
                    _buildNoVariationMessage(),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildVariationTile(
      BuildContext context,
      int index,
      ProductVariationsModel variation,
      ProductVariationsController controller) {
    return ExpansionTile(
      backgroundColor: FHelperFunctions.isDarkMode(Get.context!)
          ? FColors.darkerGrey
          : FColors.lightGrey,
      collapsedBackgroundColor: FHelperFunctions.isDarkMode(Get.context!)
          ? FColors.darkerGrey
          : FColors.lightGrey,
      childrenPadding: const EdgeInsets.all(FSizes.md),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FSizes.borderRadiusLg)),
      title: Text(variation.attributeValues.entries
          .map((entry) => '${entry.key}: ${entry.value}')
          .join(', ')),
      children: [
        // Upload Variation Image
        Obx(
          () => FImageUploader(
            imageType: variation.image.value.isNotEmpty
                ? ImageType.network
                : ImageType.asset,
            right: 0,
            left: 0,
            imageUrl: variation.image.value.isNotEmpty
                ? variation.image.value
                : FImages.defaultImageIcon,
            onIconButtonPressed: () => ProductImagesController.instance
                .selectVariationImage(variation),
          ),
        ),
        const Gap(FSizes.spaceBtwItems),

        // Variation Stock and Pricing
        Row(
          children: [
            Expanded(
              child: TextFormField(
                // Use the new controller list with index access
                controller: controller.stockControllers[index],
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                    labelText: 'Stock',
                    hintText: 'Add Stock: Only Numbers Are Allowed'),
                onChanged: (value) => variation.stock = int.parse(value),
              ),
            ),
            const Gap(FSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                // Use the new controller list with index access
                controller: controller.priceControllers[index],
                onChanged: (value) => variation.price = double.tryParse(value) ?? 0.0, // Use tryParse
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
                decoration: const InputDecoration(
                    labelText: 'Price',
                    hintText: 'Price with Up-To 2 Decimals'),
              ),
            ),
            const Gap(FSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                // Use the new controller list with index access
                controller: controller.salePriceControllers[index],
                onChanged: (value) => variation.salePrice = double.tryParse(value) ?? 0.0, // Use tryParse
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
                decoration: const InputDecoration(
                    labelText: 'Discount',
                    hintText: 'Price With Up-To 2 Decimals'),
              ),
            )
          ],
        ),
        const Gap(FSizes.spaceBtwInputFields),
        TextFormField(
          // Use the new controller list with index access
          controller: controller.descriptionControllers[index],
          onChanged: (value) => variation.description = value,
          decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Add The Description Of This Variation'),
        ),
        const Gap(FSizes.spaceBtwInputFields),
      ],
    );
  }

  // Helper method to build message when there are no variations
  Widget _buildNoVariationMessage() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FRoundedImage(
              imageType: ImageType.asset,
              width: 200,
              height: 200,
              imageUrl: FImages.defaultVariationImageIcon,
            )
          ],
        ),
        Gap(FSizes.spaceBtwItems),
        Text('There are no variations added to this product')
      ],
    );
  }
}
