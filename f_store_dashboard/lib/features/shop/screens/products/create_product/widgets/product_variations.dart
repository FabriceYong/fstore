import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/image_uploader.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
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
    return FRoundedContainer(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.dark : FColors.white,
      padding: const EdgeInsets.all(FSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Product Variations',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(
                  onPressed: () {}, child: const Text('Remove Variations')),
            ],
          ),
          const Gap(FSizes.spaceBtwItems),

          // Variations List
          ListView.separated(
            shrinkWrap: true,
            itemCount: 3,
            separatorBuilder: (_, __) => const Gap(FSizes.spaceBtwItems),
            itemBuilder: (context, index) {
              return _buildVariationTile();
            },
          ),

          // No Variation Message
          _buildNoVariationMessage(),
        ],
      ),
    );
  }

  Widget _buildVariationTile() {
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
      title: const Text('Color: Green, Size: Small'),
      children: [
        // Upload Variation Image
        Obx(
          () => FImageUploader(
            imageType: ImageType.asset,
            right: 0,
            left: 0,
            imageUrl: FImages.defaultImageIcon,
            onIconButtonPressed: () {},
          ),
        ),
        const Gap(FSizes.spaceBtwItems),

        // Variation Stock and Pricing
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                    labelText: 'Stock',
                    hintText: 'Add Stock: Only Numbers Are Allowed'),
              ),
            ),
            const Gap(FSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0-2}$'),
                  )
                ],
                decoration: const InputDecoration(
                    labelText: 'Price',
                    hintText: 'Price with Up-To 2 Decimals'),
              ),
            ),
            const Gap(FSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0-2}$'),
                  ),
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
