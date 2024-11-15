import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/layouts/grid-layout.dart';
import 'package:fstoreapp/common/widgets/schimmers/shimmer_effect.dart';

class FBrandShimmer extends StatelessWidget {
  const FBrandShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return FGridLayout(
      itemCount: itemCount,
      mainAxisExtent: 80,
      itemBuilder: (_, __) => const FShimmerEffect(
        width: 300,
        height: 80,
      ),
    );
  }
}
