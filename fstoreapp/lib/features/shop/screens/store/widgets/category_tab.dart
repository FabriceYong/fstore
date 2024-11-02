
import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/brands/brand_showcase.dart';
import 'package:fstoreapp/common/widgets/layouts/grid-layout.dart';
import 'package:fstoreapp/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:fstoreapp/common/widgets/text/section_heading.dart';
import 'package:fstoreapp/features/shop/models/category_model.dart';
import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';

class FCategoryTab extends StatelessWidget {
  const FCategoryTab({
    super.key, required this.category
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [Padding(
        padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
        child: Column(
          children: [
            /// -- Brands
            const FBrandShowcase(
              images: [
                FImages.productImage10,
                FImages.productImage1,
                FImages.productImage3,
              ],
            ),
      
            /// -- Products
            FSectionHeading(
              title: 'You might like',
              onPressed: () {},
            ),
            const Gap(FSizes.spaceBtwItems / 2),
      
            FGridLayout(itemCount: 4, itemBuilder: (context, index){
              return FProductCardVertical(product: ProductModel.empty());
            } ),
            Gap(FSizes.defaultSpace),
          ],
        ),
      ),],
    );
  }
}
