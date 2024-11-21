import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/common/widgets/images/rounded_image.dart';
import 'package:fstoreapp/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:fstoreapp/common/widgets/schimmers/horizontal_product_shimmer.dart';
import 'package:fstoreapp/common/widgets/text/section_heading.dart';
import 'package:fstoreapp/features/shop/controllers/category_controller.dart';
import 'package:fstoreapp/features/shop/models/category_model.dart';
import 'package:fstoreapp/features/shop/screens/all_products/all_products.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/cloud_helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: FAppBar(
        title: Text(
          category.name,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
          child: Column(
            children: [
              /// Banner
              const FRoundedImage(
                imageUrl: FImages.promoBanner1,
                width: double.infinity,
              ),
              const Gap(FSizes.spaceBtwItems),

              /// Sub_Categories
              FutureBuilder(
                  future: controller.getSubCategories(categoryId: category.id),
                  builder: (context, snapshot) {
                    /// Handle Loader, No Record, OR Error Message
                    const loader = FHorizontalProductShimmer();
                    final widget = FCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);

                    if (widget != null) return widget;

                    // Record Found
                    final subCategories = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: subCategories.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        
                        final subCategory = subCategories[index];

                        return FutureBuilder(
                          future: controller.getCategoryProducts(
                              categoryId: category.id),
                          builder: (context, snapshot) {
                            // Handle Loader, No Record, Or Error Message
                            final widget =
                                FCloudHelperFunctions.checkMultiRecordState(
                                    snapshot: snapshot, loader: loader);
                            if (widget != null) return widget;

                            // Record Found
                            final products = snapshot.data!;
                            return Column(
                              children: [
                                FSectionHeading(
                                  title: subCategory.name,
                                  showActionButton: true,
                                  onPressed: () => Get.to(
                                    () => AllProductsScreen(
                                      title: subCategory.name,
                                      futureMethod:
                                          controller.getCategoryProducts(
                                              categoryId: category.id,
                                              limit: -1),
                                    ),
                                  ),
                                ),
                                // const Gap(FSizes.spaceBtwItems / 2),
                                SizedBox(
                                  height: 120,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: products.length,
                                    separatorBuilder: (_, __) =>
                                        const Gap(FSizes.sm),
                                    itemBuilder: (context, index) =>
                                        FProductCardHorizontal(
                                            product: products[index]),
                                  ),
                                ),
                                const Gap(FSizes.spaceBtwItems),
                              ],
                            );
                          },
                        );
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
