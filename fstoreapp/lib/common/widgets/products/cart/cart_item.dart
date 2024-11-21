import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/images/rounded_image.dart';
import 'package:fstoreapp/common/widgets/text/product_brand_title_text_with_verified_icon.dart';
import 'package:fstoreapp/common/widgets/text/product_title_text.dart';
import 'package:fstoreapp/features/shop/models/cart_item_model.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';

class FCartItem extends StatelessWidget {
  const FCartItem({super.key, required this.cartItem});

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Image
        FRoundedImage(
          imageUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          isNetworkImage: true,
          padding: const EdgeInsets.all(FSizes.sm),
          backgroundColor: FHelperFunctions.isDarkMode(context)
              ? FColors.darkerGrey
              : FColors.light,
        ),
        const Gap(FSizes.spaceBtwItems),

        /// Title, Price & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FBrandTitleTextWithVerifiedIcon(title: cartItem.brandName ?? ''),
              Flexible(
                child: FProductTitleText(title: cartItem.title ?? ''),
              ),

              /// Attributes
              Text.rich(
                TextSpan(
                  children: (cartItem.selectedVariations ?? {})
                      .entries
                      .map(
                        (item) => TextSpan(
                          children: [
                            TextSpan(
                                text: '${item.key}',
                                style: Theme.of(context).textTheme.bodySmall),
                            TextSpan(
                                text: '${item.value}',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
