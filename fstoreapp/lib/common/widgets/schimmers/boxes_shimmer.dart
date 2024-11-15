import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/schimmers/shimmer_effect.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';

class FBoxesShimmer extends StatelessWidget {
  const FBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: FShimmerEffect(width: 150, height: 110)),
            Gap(FSizes.spaceBtwItems),
            Expanded(child: FShimmerEffect(width: 150, height: 110)),
            Gap(FSizes.spaceBtwItems),
            Expanded(child: FShimmerEffect(width: 150, height: 110))
          ],
        )
      ],
    );
  }
}
