import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/chips/choice_chip.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fstoreapp/common/widgets/text/product_price_text.dart';
import 'package:fstoreapp/common/widgets/text/product_title_text.dart';
import 'package:fstoreapp/common/widgets/text/section_heading.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';

class FProductAttributes extends StatelessWidget {
  const FProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        /// -- Selected Attributes, Pricing, and Description
        FRoundedContainer(
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
                          Text(
                            '\$25',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const Gap(FSizes.spaceBtwItems / 2),

                          /// Sale Price
                          const FProductPriceText(price: '20'),
                        ],
                      ),

                      /// Status
                      Row(
                        children: [
                          const FProductTitleText(
                            title: 'Stock',
                            smallSize: true,
                          ),
                          const Gap(FSizes.spaceBtwItems),
                          Text('In Stock',
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      )
                    ],
                  ),
                ],
              ),

              /// Variation Description
              const FProductTitleText(
                title:
                    'This is a Desctiption of the product and it can go up to max 4 lines',
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),
        const Gap(FSizes.spaceBtwItems),

        /// -- Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FSectionHeading(
              title: 'Colors',
              showActionButton: false,
            ),
            const Gap(FSizes.spaceBtwItems / 2),
            Wrap(
              children: [
                FChoiceChip(
                  text: 'Green',
                  selected: true,
                  onSelected: (value) {},
                ),
                FChoiceChip(
                  text: 'Yellow',
                  selected: false,
                  onSelected: (value) {},
                ),
                FChoiceChip(
                  text: 'Blue',
                  selected: false,
                  onSelected: (value) {},
                ),
                FChoiceChip(
                  text: 'Red',
                  selected: true,
                  onSelected: (value) {},
                ),
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FSectionHeading(
              title: 'Size',
              showActionButton: false,
            ),
            const Gap(FSizes.spaceBtwItems / 1),
            Wrap(
              spacing: FSizes.sm,
              children: [
                FChoiceChip(
                  text: 'EU 34',
                  selected: false,
                  onSelected: (value) {},
                ),
                FChoiceChip(
                  text: 'EU 36',
                  selected: true,
                  onSelected: (value) {},
                ),
                FChoiceChip(
                  text: 'EU 38',
                  selected: false,
                  onSelected: (value) {},
                ),
                FChoiceChip(
                  text: 'EU 40',
                  selected: true,
                  onSelected: (value) {},
                ),
                FChoiceChip(
                  text: 'EU 40',
                  selected: true,
                  onSelected: (value) {},
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
