import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/schimmers/shimmer_effect.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';

class FListTileShimmer extends StatelessWidget {
  const FListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            FShimmerEffect(
              width: 50,
              height: 50,
              radius: 50,
            ),
            Gap(FSizes.spaceBtwItems),
            Column(
              children: [
                FShimmerEffect(width: 100, height: 15),
                Gap(FSizes.spaceBtwItems / 2),
                FShimmerEffect(
                  width: 80,
                  height: 12,
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
