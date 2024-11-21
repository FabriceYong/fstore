import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/schimmers/shimmer_effect.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';

class FHorizontalProductShimmer extends StatelessWidget {
  const FHorizontalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: FSizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const Gap(FSizes.spaceBtwItems),
        itemBuilder: (_, __) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Image
            FShimmerEffect(width: 120, height: 120),
            Gap(FSizes.spaceBtwItems),

            /// Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(FSizes.spaceBtwItems / 2),
                FShimmerEffect(width: 160, height: 15),
                Gap(FSizes.spaceBtwItems / 2),
                FShimmerEffect(width: 110, height: 15),
                Gap(FSizes.spaceBtwItems / 2),
                FShimmerEffect(width: 80, height: 15),
                Gap(FSizes.spaceBtwItems / 2),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
