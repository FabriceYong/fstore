import 'package:f_store_dashboard/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/product_images_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/products/create_product/widgets/product_additional_images.dart';
import 'package:f_store_dashboard/features/shop/screens/products/create_product/widgets/product_attributes.dart';
import 'package:f_store_dashboard/features/shop/screens/products/create_product/widgets/product_bottom_navigation_buttons.dart';
import 'package:f_store_dashboard/features/shop/screens/products/create_product/widgets/product_brand.dart';
import 'package:f_store_dashboard/features/shop/screens/products/create_product/widgets/product_categories.dart';
import 'package:f_store_dashboard/features/shop/screens/products/create_product/widgets/product_stock_and_pricing.dart';
import 'package:f_store_dashboard/features/shop/screens/products/create_product/widgets/product_thumbnail_image.dart';
import 'package:f_store_dashboard/features/shop/screens/products/create_product/widgets/product_title_and_desc.dart';
import 'package:f_store_dashboard/features/shop/screens/products/create_product/widgets/product_type_widget.dart';
import 'package:f_store_dashboard/features/shop/screens/products/create_product/widgets/product_variations.dart';
import 'package:f_store_dashboard/features/shop/screens/products/create_product/widgets/product_visibility_widget.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CreateProductDesktop extends StatelessWidget {
  const CreateProductDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(CreateProductController());
    final productImagesController = Get.put(ProductImagesController());
    return Scaffold(
      backgroundColor: FHelperFunctions.isDarkMode(context)
          ? Colors.black
          : FColors.primaryBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Breadcrumbs
              const BreadcrumbWithHeading(
                  returnToPrevScreen: true,
                  heading: 'Create Product',
                  breadcrumbItems: [FRoutes.createProduct, 'Create Product']),
              const Gap(FSizes.spaceBtwSections),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: FDeviceUtils.isTabletScreen(context) ? 2 : 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Basic Information
                        const ProductTitleAndDescription(),
                        const Gap(FSizes.spaceBtwSections),

                        // Stock and Pricing
                        FRoundedContainer(
                          backgroundColor: FHelperFunctions.isDarkMode(context)
                              ? FColors.black
                              : FColors.white,
                          padding: const EdgeInsets.all(FSizes.md),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Stock & Pricing',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              const Gap(FSizes.spaceBtwItems),

                              // Product Type
                              const ProductTypeWidget(),
                              const Gap(FSizes.spaceBtwInputFields),

                              // Stock
                              const ProductStockAndPricing(),
                              const Gap(FSizes.spaceBtwSections),

                              // Attributes
                              const ProductAttributes(),
                              const Gap(FSizes.spaceBtwSections),
                            ],
                          ),
                        ),
                        const Gap(FSizes.spaceBtwSections),

                        // Variations
                        const ProductVariations(),
                      ],
                    ),
                  ),
                  const Gap(FSizes.defaultSpace),

                  // Sidebar
                  Expanded(
                      child: Column(
                    children: [
                      // Product thumbnail
                      const ProductThumbnailImage(),
                      const Gap(FSizes.spaceBtwSections),

                      // Product Image
                      FRoundedContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'All Product Images',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const Gap(FSizes.spaceBtwItems),
                            ProductAdditionalImages(
                              additionalProductImageUrls:
                                  productImagesController
                                      .additionalProductImageUrls,
                              onTapToAddImages: () => productImagesController
                                  .selectMultipleProductImages(),
                              onTapToRemoveImage: (index) =>
                                  productImagesController.removeImage(index),
                            ),
                          ],
                        ),
                      ),
                      const Gap(FSizes.spaceBtwSections),

                      // Product Brand
                      const ProductBrand(),
                      const Gap(FSizes.spaceBtwSections),

                      // Product Categories
                      const ProductCategories(),
                      const Gap(FSizes.spaceBtwSections),

                      // Product Visibility
                      const ProductVisibilityWidget(),
                      const Gap(FSizes.spaceBtwSections),
                    ],
                  ))
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ProductBottomNavigationButtons(),
    );
  }
}
