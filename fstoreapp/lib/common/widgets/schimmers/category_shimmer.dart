import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/schimmers/shimmer_effect.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';

class FCategoryShimmer extends StatelessWidget {
  const FCategoryShimmer({super.key, this.itemCount = 8});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const Gap(FSizes.spaceBtwItems),
        itemBuilder: (context, index) => const Column(
          children: [
            FShimmerEffect(
              width: 55,
              height: 55,
              radius: 100,
            ),
            Gap(FSizes.spaceBtwItems / 2),

            /// Text
            FShimmerEffect(width: 55, height: 8),
          ],
        ),
      ),
    );
  }
}
