import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:fstoreapp/common/widgets/layouts/grid-layout.dart';
import 'package:fstoreapp/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:fstoreapp/common/widgets/schimmers/vertical_product_shimmer.dart';
import 'package:fstoreapp/common/widgets/text/section_heading.dart';
import 'package:fstoreapp/features/shop/controllers/product/products_controller.dart';
import 'package:fstoreapp/features/shop/screens/all_products/all_products.dart';
import 'package:fstoreapp/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:fstoreapp/features/shop/screens/home/widgets/home_categories.dart';
import 'package:fstoreapp/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// -- Appbar
                  const FHomeAppBar(),
                  const Gap(FSizes.defaultSpace),

                  /// -- Search bar
                  const FSearchContainer(
                    text: 'Search in Store',
                    icon: Iconsax.search_normal,
                  ),
                  const Gap(FSizes.spaceBtwItems),

                  /// -- Categories
                  Padding(
                    padding: const EdgeInsets.only(left: FSizes.md),
                    child: Column(
                      /// - Heading
                      children: [
                        FSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: true,
                          onPressed: () => Get.to(
                            () => AllProductsScreen(
                              title: 'Popular Products',
                              // query: FirebaseFirestore.instance
                              //     .collection('Products')
                              //     .where('IsFeatured', isEqualTo: true)
                              //     .limit(6),
                              futureMethod:
                                  controller.fetchAllFeaturedProducts(),
                            ),
                          ),
                        ),

                        /// Categories
                        const FHomeCategories(),
                        const Gap(FSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// --- Body
            Padding(
              padding: const EdgeInsets.all(FSizes.md),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Banners -- Promo Sliders
                  const FPromoSlider(),
                  controller.isLoading.value
                      ? const Gap(FSizes.spaceBtwItems)
                      : const Gap(FSizes.spaceBtwItems / 2),

                  /// -- Popular Products
                  Obx(() {
                    if (controller.isLoading.value)
                      return const FVerticalProductShimmer();

                    if (controller.featuredProducts.isEmpty) {
                      return Center(
                        child: Text(
                          'No Data Found',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }
                    return FGridLayout(
                      itemCount: controller.featuredProducts.length,
                      itemBuilder: (context, index) => FProductCardVertical(
                        product: controller.featuredProducts[index],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
