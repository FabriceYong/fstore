import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/brands/brand_showcase.dart';
import 'package:fstoreapp/common/widgets/schimmers/boxes_shimmer.dart';
import 'package:fstoreapp/common/widgets/schimmers/list_tile_shimmer.dart';
import 'package:fstoreapp/features/shop/controllers/brands_controller.dart';
import 'package:fstoreapp/features/shop/models/category_model.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/cloud_helper_functions.dart';
import 'package:gap/gap.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandsController.instance;
    return FutureBuilder(
        future: controller.getBrandsForCategory(category.id),
        builder: (context, snapshot) {
          const loader = Column(
            children: [
              FListTileShimmer(),
              Gap(FSizes.spaceBtwItems),
              FBoxesShimmer(),
              Gap(FSizes.spaceBtwItems)
            ],
          );

          final widget = FCloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, loader: loader);
          if (widget != null) return widget;

          // Record Found
          final brands = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            itemCount: brands.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final brand = brands[index];
              return FutureBuilder(
                future:
                    controller.getBrandProducts(brandId: brand.id, limit: 3),
                builder: (context, snapshot) {
                  /// Handle Loader, No Record, Or Error Message
                  final widget = FCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  /// Record Found
                  final products = snapshot.data!;

                  return FBrandShowcase(
                    images:
                        products.map((product) => product.thumbnail).toList(),
                    brand: brand,
                  );
                },
              );
            },
          );
        });
  }
}
