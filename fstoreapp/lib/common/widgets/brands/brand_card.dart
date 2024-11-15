import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fstoreapp/common/widgets/images/circular_image.dart';
import 'package:fstoreapp/common/widgets/text/product_brand_title_text_with_verified_icon.dart';
import 'package:fstoreapp/features/shop/models/brand_model.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/enums.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';

class FBrandCard extends StatelessWidget {
  const FBrandCard(
      {super.key, required this.showBorder, this.onTap, required this.brand});

  final bool showBorder;
  final void Function()? onTap;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: FRoundedContainer(
        padding: const EdgeInsets.all(FSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            /// -- Icon
            Flexible(
              child: FCircularImage(
                isNetworkImage: true,
                image: brand.image,
                backgroundColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.dark
                    : FColors.white,
                overlayColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.white
                    : FColors.black,
              ),
            ),
            const Gap(FSizes.spaceBtwItems / 2),

            /// -- Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FBrandTitleTextWithVerifiedIcon(
                    title: brand.name,
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '${brand.productsCount ?? 0} ${brand.productsCount == 1 ? 'Product' : 'Products'}',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
