
import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/common/widgets/brands/brand_card.dart';
import 'package:fstoreapp/common/widgets/products/sortable/sortable_products.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: FAppBar(
        title: Text('Nike'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(FSizes.defaultSpace / 2),
          child: Column(
            children: [
              /// Brand Detail
              FBrandCard(showBorder: true),
              Gap(FSizes.spaceBtwItems),

              FSortableProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
