import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fstoreapp/common/widgets/icons/circular_icon.dart';
import 'package:fstoreapp/common/widgets/icons/favourite_icon.dart';
import 'package:fstoreapp/common/widgets/images/rounded_image.dart';
import 'package:fstoreapp/common/widgets/text/product_brand_title_text_with_verified_icon.dart';
import 'package:fstoreapp/common/widgets/text/product_price_text.dart';
import 'package:fstoreapp/common/widgets/text/product_title_text.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class FProductCardHorizontal extends StatelessWidget {
  const FProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: FColors.darkGrey.withOpacity(.1),
              blurRadius: 1,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(FSizes.productImageRadius),
          color: FHelperFunctions.isDarkMode(context)
              ? FColors.darkerGrey
              : FColors.softGrey),
      child: Row(
        children: [
          /// Thumbnail
          FRoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(FSizes.sm),
            backgroundColor: FHelperFunctions.isDarkMode(context)
                ? FColors.dark
                : FColors.light,
            child: Stack(
              children: [
                /// Thumbnail Image
                const SizedBox(
                  width: 120,
                  height: 120,
                  child: FRoundedImage(
                    imageUrl: FImages.productImage1,
                    applyImageRadius: true,
                  ),
                ),

                /// -- Sale Tag
                Positioned(
                  top: 12,
                  child: FRoundedContainer(
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
                ),

                /// -- Favourite Icon
                const Positioned(
                  top: 0,
                  right: 0,
                  child: FFavoriteIcon(productId: '',)
                )
              ],
            ),
          ),

          /// -- Details
          SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(top: FSizes.sm, left: FSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FProductTitleText(
                    title: 'Green Nike Shoes',
                    smallSize: true,
                  ),
                  const Gap(FSizes.spaceBtwItems / 2),
                  const FBrandTitleTextWithVerifiedIcon(title: 'Nike'),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Pricing
                      const Flexible(child: FProductPriceText(price: '256.0')),

                      /// Add To Cart
                      Container(
                        decoration: const BoxDecoration(
                            color: FColors.dark,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(FSizes.cardRadiusMd),
                              bottomRight:
                                  Radius.circular(FSizes.productImageRadius),
                            )),
                        child: const SizedBox(
                          width: FSizes.iconLg * 1.2,
                          height: FSizes.iconLg * 1.2,
                          child: Center(
                            child: Icon(
                              Iconsax.add,
                              color: FColors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
