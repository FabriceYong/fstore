import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/text/section_heading.dart';
import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:fstoreapp/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:fstoreapp/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:fstoreapp/features/shop/screens/product_details/widgets/product_details_image_slider.dart';
import 'package:fstoreapp/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:fstoreapp/features/shop/screens/product_details/widgets/ratings_and_share.dart';
import 'package:fstoreapp/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const FBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1 - Product Image Slider
            const FProductDetailsImageSlider(),

            /// 2 - Product Details
            Padding(
              padding: const EdgeInsets.only(
                  right: FSizes.defaultSpace / 2,
                  left: FSizes.defaultSpace / 2,
                  bottom: FSizes.defaultSpace / 2),
              child: Column(
                children: [
                  /// - Ratins & Share Button
                  const FRatingsAndShare(),

                  /// Price, Title, Stock, & Brand
                  const FProductMetaData(),

                  /// -- Attributes
                  const FProductAttributes(),
                  const Gap(FSizes.spaceBtwSections),

                  /// -- Checkout button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Checkout')),
                  ),
                  const Gap(FSizes.spaceBtwSections),

                  /// -- Description
                  const FSectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const Gap(FSizes.spaceBtwItems / 2),
                  const ReadMoreText(
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' show more',
                    trimExpandedText: ' show less',
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    'This is a Product description Iphone 15 Pro Max. This is a Product description Iphone 15 Pro Max. This is a Product description Iphone 15 Pro Max. This is a Product description Iphone 15 Pro Max.',
                  ),

                  /// -- Reviews
                  const Divider(),
                  const Gap(FSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const FSectionHeading(
                        title: 'Reviews (199)',
                        showActionButton: false,
                      ),
                      IconButton(
                        onPressed: () => Get.to(() => const ProductReviews()),
                        icon: const Icon(
                          Iconsax.arrow_right_3,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const Gap(FSizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
