import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/common/widgets/brands/brand_card.dart';
import 'package:fstoreapp/common/widgets/products/sortable/sortable_products.dart';
import 'package:fstoreapp/common/widgets/schimmers/vertical_product_shimmer.dart';
import 'package:fstoreapp/features/shop/controllers/brands_controller.dart';
import 'package:fstoreapp/features/shop/models/brand_model.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/cloud_helper_functions.dart';
import 'package:gap/gap.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandsController.instance;
    return Scaffold(
      appBar: FAppBar(
        title: Text(brand.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
          child: Column(
            children: [
              /// Brand Detail
              FBrandCard(
                showBorder: true,
                brand: brand,
              ),
              const Gap(FSizes.spaceBtwItems),

              FutureBuilder(
                future: controller.getBrandProducts(brandId: brand.id),
                builder: (context, snapshot) {
                  /// Handle Loader, No Record, Or Error Message
                  const loader = FVerticalProductShimmer(
                    itemCount: 6,
                  );
                  final widget = FCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);

                  if (widget != null) return widget;

                  /// Record Found
                  final brandProducts = snapshot.data!;
                  return FSortableProducts(
                    products: brandProducts,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
