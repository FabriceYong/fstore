import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/layouts/grid-layout.dart';
import 'package:fstoreapp/common/widgets/schimmers/shimmer_effect.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';

class FVerticalProductShimmer extends StatelessWidget {
  const FVerticalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return FGridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            FShimmerEffect(width: 180, height: 180),
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
