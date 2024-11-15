import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/layouts/grid-layout.dart';
import 'package:fstoreapp/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:fstoreapp/common/widgets/schimmers/vertical_product_shimmer.dart';
import 'package:fstoreapp/common/widgets/text/section_heading.dart';
import 'package:fstoreapp/features/shop/controllers/category_controller.dart';
import 'package:fstoreapp/features/shop/models/brand_model.dart';
import 'package:fstoreapp/features/shop/models/category_model.dart';
import 'package:fstoreapp/features/shop/screens/all_products/all_products.dart';
import 'package:fstoreapp/features/shop/screens/store/widgets/category_brands.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/cloud_helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FCategoryTab extends StatelessWidget {
  const FCategoryTab({super.key, required this.category, required this.brand});

  final CategoryModel category;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
          child: Column(
            children: [
              /// -- Brands
              CategoryBrands(category: category,),
              const Gap(FSizes.spaceBtwItems),

              /// -- Products
              FutureBuilder(
                  future:
                      controller.getCategoryProducts(categoryId: category.id),
                  builder: (context, snapshot) {
                    /// Helper Function: Handle Loader, No Record, Or Error Message
                    final response =
                        FCloudHelperFunctions.checkMultiRecordState(
                            snapshot: snapshot,
                            loader: const FVerticalProductShimmer());
                    if (response != null) return response;

                    /// Record Found
                    final products = snapshot.data!;
                    return Column(
                      children: [
                        FSectionHeading(
                          title: 'You might like',
                          onPressed: () => Get.to(
                            () => AllProductsScreen(
                              title: category.name,
                              futureMethod: controller.getCategoryProducts(
                                  categoryId: category.id, limit: -1),
                            ),
                          ),
                        ),
                        const Gap(FSizes.spaceBtwItems),
                        FGridLayout(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return FProductCardVertical(
                                  product: products[index]);
                            }),
                      ],
                    );
                  })
            ],
          ),
        ),
      ],
    );
  }
}
