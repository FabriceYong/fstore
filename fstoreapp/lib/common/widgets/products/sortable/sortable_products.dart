import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/layouts/grid-layout.dart';
import 'package:fstoreapp/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class FSortableProducts extends StatelessWidget {
  const FSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Dropdown menu
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          items: [
            'Name',
            'Higher Price',
            'Lower Price',
            'Sale',
            'Newest',
            'Popularity'
          ]
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: (value) {},
        ),
        const Gap(FSizes.spaceBtwItems),

        /// All Products
        FGridLayout(
          itemCount: 6,
          itemBuilder: (context, index) =>  FProductCardVertical(product: ProductModel.empty()),
        ),
      ],
    );
  }
}
