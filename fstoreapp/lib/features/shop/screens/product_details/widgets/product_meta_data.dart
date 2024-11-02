import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fstoreapp/common/widgets/images/circular_image.dart';
import 'package:fstoreapp/common/widgets/text/product_brand_title_text_with_verified_icon.dart';
import 'package:fstoreapp/common/widgets/text/product_price_text.dart';
import 'package:fstoreapp/common/widgets/text/product_title_text.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/enums.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';

class FProductMetaData extends StatelessWidget {
  const FProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// Sale Tag
            FRoundedContainer(
              radius: FSizes.sm,
              backgroundColor: FColors.secondary.withOpacity(.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: FSizes.sm, vertical: FSizes.xs),
              child: Text(
                '25%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: FColors.black),
              ),
            ),
            const Gap(FSizes.spaceBtwItems),

            /// Price
            Text('\$850',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough)),
            const Gap(FSizes.spaceBtwItems / 2),
            const FProductPriceText(price: '830', isLarge: true),
            const Gap(FSizes.spaceBtwItems / 2.5),
          ],
        ),
        const Gap(FSizes.spaceBtwItems / 2.5),

        /// Title
        const FProductTitleText(title: 'Iphone 15 Pro Max'),
        const Gap(FSizes.spaceBtwItems / 2.5),

        /// Stock Status
        Row(
          children: [
            const FProductTitleText(title: 'Status'),
            const Gap(FSizes.spaceBtwItems / 2),
            Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),

        const Gap(FSizes.spaceBtwItems / 2.5),

        /// Brand
        Row(
          children: [
            FCircularImage(
                image: FImages.electronicsIcon,
                width: 32,
                height: 32,
                overlayColor: dark ? FColors.white : FColors.black),
            const FBrandTitleTextWithVerifiedIcon(
                title: 'Apple', brandTextSize: TextSizes.medium),
          ],
        ),
        const Gap(FSizes.spaceBtwItems),
      ],
    );
  }
}
