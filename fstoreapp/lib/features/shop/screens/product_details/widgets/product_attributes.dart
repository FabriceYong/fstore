import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/chips/choice_chip.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fstoreapp/common/widgets/text/product_price_text.dart';
import 'package:fstoreapp/common/widgets/text/product_title_text.dart';
import 'package:fstoreapp/common/widgets/text/section_heading.dart';
import 'package:fstoreapp/features/shop/controllers/product/variation_controller.dart';
import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FProductAttributes extends StatelessWidget {
  const FProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    final dark = FHelperFunctions.isDarkMode(context);
    print(controller.selectedVariation.value.attributes);
    return Column(
      children: [
        /// -- Selected Attributes, Pricing, and Description
        //
        Obx(
          () => controller.selectedVariation.value.id.isNotEmpty
              ? FRoundedContainer(
                  padding: const EdgeInsets.all(FSizes.md),
                  backgroundColor: dark ? FColors.darkerGrey : FColors.grey,
                  child: Column(
                    children: [
                      /// Title, Price and Stock Status
                      Row(
                        children: [
                          const FSectionHeading(
                            title: 'Variations',
                            showActionButton: false,
                          ),
                          const Gap(FSizes.spaceBtwItems),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const FProductTitleText(
                                    title: 'Price',
                                    smallSize: true,
                                  ),
                                  const Gap(FSizes.spaceBtwItems),
                                  if (controller
                                          .selectedVariation.value.salePrice >
                                      0)
                                    Text(
                                      '\$${controller.selectedVariation.value.salePrice}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .apply(
                                              decoration:
                                                  TextDecoration.lineThrough),
                                    ),
                                  if (controller
                                          .selectedVariation.value.salePrice >
                                      0)
                                    const Gap(FSizes.spaceBtwItems / 2),

                                  /// Sale Price
                                  FProductPriceText(
                                      price: controller.getVariationPrice()),
                                ],
                              ),

                              /// Status
                              Row(
                                children: [
                                  const FProductTitleText(
                                    title: 'Stock:',
                                    smallSize: true,
                                  ),
                                  const Gap(FSizes.spaceBtwItems),
                                  Text(controller.variationStockStatus.value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),

                      /// Variation Description
                      FProductTitleText(
                        title: controller.selectedVariation.value.description ??
                            '',
                        smallSize: true,
                        maxLines: 4,
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ),
        const Gap(FSizes.spaceBtwItems),

        /// -- Attributes
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FSectionHeading(
                        title: attribute.name ?? '',
                        showActionButton: false,
                      ),
                      const Gap(FSizes.spaceBtwItems / 2),
                      Wrap(
                        spacing: 8,
                        children: attribute.values!.map((value) {
                          final bool isSelected =
                              controller.selectedAttributes[attribute.name] ==
                                  value;

                          final available = controller
                              .getAttributesAvailabilityInVariation(
                                  product.productVariations!, attribute.name!)
                              .contains(value);

                          return FChoiceChip(
                            text: value,
                            selected: isSelected,
                            onSelected: available
                                ? (selected) {
                                    if (selected && available) {
                                      controller.onAttributeSelected(
                                          product, attribute.name ?? '', value);
                                    }
                                  }
                                : null,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
