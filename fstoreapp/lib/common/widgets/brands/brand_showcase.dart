import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/brands/brand_card.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fstoreapp/common/widgets/schimmers/shimmer_effect.dart';
import 'package:fstoreapp/features/shop/models/brand_model.dart';
import 'package:fstoreapp/features/shop/screens/brands/brand_products.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class FBrandShowcase extends StatelessWidget {
  const FBrandShowcase({super.key, required this.images, required this.brand});

  final List<String> images;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: FRoundedContainer(
        showBorder: true,
        borderColor: FColors.darkGrey,
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: FSizes.defaultSpace),
        child: Column(
          children: [
            /// Brand with Products count
            FBrandCard(
              showBorder: false,
              brand: brand,
              onTap: () {},
            ),

            /// Brand Top 3 Product Images
            /// Make the image at index 0 expanded with a flex of 1
            Row(
                children: images
                    .asMap()
                    .map((index, image) => MapEntry(index,
                        brandTopProductImageWidget(image, context, index)))
                    .values
                    .toList()),
          ],
        ),
      ),
    );
  }
}

Widget brandTopProductImageWidget(
    String image, BuildContext context, int? index) {
  return Expanded(
    flex: index == 0 ? 1 : 0,
    child: FRoundedContainer(
      height: 100,
      backgroundColor: FHelperFunctions.isDarkMode(context)
          ? FColors.darkerGrey
          : FColors.light,
      margin: const EdgeInsets.all(FSizes.sm),
      padding: const EdgeInsets.all(FSizes.md),
      child: CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl: image,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              const FShimmerEffect(width: 100, height: 100, radius: 100),
          errorWidget: (context, url, error) => const Icon(Icons.error)),
    ),
  );
}
