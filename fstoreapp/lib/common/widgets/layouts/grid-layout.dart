import 'package:flutter/material.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';

class FGridLayout extends StatelessWidget {
  const FGridLayout(
      {super.key,
      required this.itemBuilder,
      required this.itemCount,
      this.crossAxisCount = 2,
      this.mainAxisExtent = 288});

  final int itemCount, crossAxisCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: FSizes.gridViewSpacing,
        crossAxisSpacing: FSizes.gridViewSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
