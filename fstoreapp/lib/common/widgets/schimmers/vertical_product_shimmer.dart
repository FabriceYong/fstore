import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/layouts/grid-layout.dart';
import 'package:fstoreapp/common/widgets/schimmers/shimmer_effect.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';

class FVerticalProductShimmer extends StatelessWidget {
  const FVerticalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final screenWidth = FHelperFunctions.screenWidth();
    final cardWidth = screenWidth * .45; // Occupy 45% of the screen
    final cardHeight = cardWidth * 1.3; // Maintain aspect ratio
    return FGridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => SizedBox(
        width: screenWidth,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            FShimmerEffect(width: 200, height: 200),
            Gap(FSizes.spaceBtwItems),

            /// Text
            FShimmerEffect(width: 160, height: 15),
            Gap(FSizes.spaceBtwItems / 2),
            FShimmerEffect(
              width: 110,
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
