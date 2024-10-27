import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fstoreapp/common/widgets/icons/circular_icon.dart';
import 'package:fstoreapp/common/widgets/images/rounded_image.dart';
import 'package:fstoreapp/common/widgets/text/product_brand_title_text_with_verified_icon.dart';
import 'package:fstoreapp/common/widgets/text/product_price_text.dart';
import 'package:fstoreapp/common/widgets/text/product_title_text.dart';
import 'package:fstoreapp/features/shop/screens/product_details/product_details.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FProductCardVertical extends StatelessWidget {
  const FProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    final screenWidth = FHelperFunctions.screenWidth();
    final cardWidth = screenWidth * .45; // Occupy 45% of the screen
    final cardHeight = cardWidth * 1.3; // Maintain aspect ratio

    /// Container with side paddings, color, edges, radius and shadow
    return InkWell(
      onTap: () => Get.to(() => const ProductDetails()),
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: FColors.darkGrey.withOpacity(.1),
              blurRadius: 5,
              spreadRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(FSizes.productImageRadius),
          color: dark ? FColors.darkerGrey : FColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thumbnail, Wishlist button Discount Tag
            FRoundedContainer(
              height: cardHeight * .75,
              padding: const EdgeInsets.all(FSizes.sm),
              backgroundColor: dark ? FColors.dark : FColors.light,
              child: Stack(
                children: [
                  /// Thumbnail Image
                  const FRoundedImage(
                    imageUrl: FImages.productImage1,
                    width: double.infinity,
                    applyImageRadius: true,
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
                  const Positioned(
                      top: 0,
                      right: 0,
                      child: FCircularIcon(
                        icon: Iconsax.heart5,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            const Gap(FSizes.spaceBtwItems / 2),

            /// -- Details
            const Padding(
              padding: EdgeInsets.only(left: FSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FProductTitleText(
                    title: 'Green Nike Air Shoes',
                    smallSize: true,
                  ),
                  Gap(FSizes.spaceBtwItems / 2),
                  FBrandTitleTextWithVerifiedIcon(
                    title: 'Nike',
                  ),
                ],
              ),
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Price
                const Padding(
                  padding: EdgeInsets.only(left: FSizes.sm),
                  child: FProductPriceText(
                    price: '35.6',
                    isLarge: false,
                  ),
                ),

                Container(
                  decoration: const BoxDecoration(
                    color: FColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(FSizes.cardRadiusLg),
                      bottomRight: Radius.circular(FSizes.productImageRadius),
                    ),
                  ),
                  child: const SizedBox(
                      width: FSizes.iconLg * 1.2,
                      height: FSizes.iconLg * 1.2,
                      child: Center(
                        child: Icon(
                          Iconsax.add,
                          color: FColors.white,
                        ),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
