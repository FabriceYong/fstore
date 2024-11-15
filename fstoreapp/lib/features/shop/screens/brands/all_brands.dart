import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/common/widgets/brands/brand_card.dart';
import 'package:fstoreapp/common/widgets/layouts/grid-layout.dart';
import 'package:fstoreapp/common/widgets/schimmers/brand_shimmer.dart';
import 'package:fstoreapp/common/widgets/text/section_heading.dart';
import 'package:fstoreapp/features/shop/controllers/brands_controller.dart';
import 'package:fstoreapp/features/shop/screens/brands/brand_products.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandsController.instance;
    return Scaffold(
      appBar: const FAppBar(
        title: Text('Brands'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
          child: Column(
            children: [
              /// Heading
              const FSectionHeading(
                title: 'Brands',
                showActionButton: false,
              ),
              const Gap(FSizes.spaceBtwItems),

              /// Brands
              Obx(() {
                if (controller.isLoading.value) {
                  return const FBrandShimmer();
                }

                if (controller.allBrands.isEmpty) {
                  return Center(
                    child: Text(
                      'No Data Found',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: FHelperFunctions.isDarkMode(context)
                              ? Colors.white
                              : Colors.black),
                    ),
                  );
                }
                return FGridLayout(
                  itemCount: controller.allBrands.length,
                  mainAxisExtent: 80,
                  itemBuilder: (context, index) => FBrandCard(
                    showBorder: true,
                    brand: controller.allBrands[index],
                    onTap: () => Get.to(() => BrandProducts(
                          brand: controller.allBrands[index],
                        )),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
