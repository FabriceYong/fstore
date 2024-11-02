
import 'package:f_store_dashboard/common/widgets/schimmers/shimmer_effect.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FCategoryShimmer extends StatelessWidget {
  const FCategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        shrinkWrap: true,
        separatorBuilder: (_, __) => const Gap(FSizes.spaceBtwItems),
        itemBuilder: (_, index) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              FShimmerEffect(
                width: 55,
                height: 55,
                radius: 55,
              ),
              Gap(FSizes.spaceBtwItems / 2),

              /// Text
              FShimmerEffect(width: 55, height: 8),
            ],
          );
        },
      ),
    );
  }
}
