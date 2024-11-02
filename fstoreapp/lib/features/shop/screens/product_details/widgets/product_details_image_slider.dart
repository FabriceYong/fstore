import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:fstoreapp/common/widgets/icons/circular_icon.dart';
import 'package:fstoreapp/common/widgets/images/rounded_image.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class FProductDetailsImageSlider extends StatelessWidget {
  const FProductDetailsImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FCurvedEdgesWidget(
        child: Container(
      color: FHelperFunctions.isDarkMode(context)
          ? FColors.darkerGrey
          : FColors.light,
      child: Stack(
        children: [
          /// Main Large Image
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(FSizes.productImageRadius * 2),
              child: Image.asset(FImages.productImage51),
            ),
          ),

          /// AppBar Icons
          const FAppBar(
            showBackArrow: true,
            actions: [
              FCircularIcon(
                icon: Iconsax.heart,
                color: Colors.red,
              ),
            ],
          ),

          /// Image Slider
          Positioned(
            right: 0,
            bottom: 30,
            left: FSizes.defaultSpace / 2,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: 6,
                separatorBuilder: (_, __) =>
                    const Gap(FSizes.spaceBtwItems / 2),
                itemBuilder: (context, index) {
                  return FRoundedImage(
                    width: 80,
                    imageUrl: FImages.productImage51,
                    border: Border.all(color: FColors.primary),
                    padding: const EdgeInsets.all(FSizes.sm),
                    backgroundColor: FHelperFunctions.isDarkMode(context)
                        ? FColors.dark
                        : FColors.white,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
