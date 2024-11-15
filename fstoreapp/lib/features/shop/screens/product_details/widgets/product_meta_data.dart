import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fstoreapp/common/widgets/images/circular_image.dart';
import 'package:fstoreapp/common/widgets/text/product_brand_title_text_with_verified_icon.dart';
import 'package:fstoreapp/common/widgets/text/product_price_text.dart';
import 'package:fstoreapp/common/widgets/text/product_title_text.dart';
import 'package:fstoreapp/features/shop/controllers/product/products_controller.dart';
import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/enums.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';

class FProductMetaData extends StatelessWidget {
  const FProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// Sale Tag
            FRoundedContainer(
              radius: FSizes.sm,
              backgroundColor: FColors.secondary.withOpacity(.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: FSizes.sm, vertical: FSizes.xs),
              child: Text(
                '$salePercentage%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: FColors.black),
              ),
            ),
            const Gap(FSizes.spaceBtwItems),

            /// Price
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              Text(
                '\$${product.price}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough),
              ),

            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              const Gap(FSizes.spaceBtwItems / 2),
            FProductPriceText(
                price: controller.getProductPrice(product), isLarge: true),
            const Gap(FSizes.spaceBtwItems / 2.5),
          ],
        ),
        const Gap(FSizes.spaceBtwItems / 2.5),

        /// Title
        FProductTitleText(title: product.title),
        const Gap(FSizes.spaceBtwItems / 2.5),

        /// Stock Status
        Row(
          children: [
            const FProductTitleText(title: 'Status:'),
            const Gap(FSizes.spaceBtwItems / 2),
            Text(controller.getProductsStocksStatus(product.stock),
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),

        const Gap(FSizes.spaceBtwItems / 2.5),

        /// Brand
        Row(
          children: [
            FCircularImage(
              image: product.brand != null ? product.brand!.image : '',
              width: 32,
              height: 32,
              overlayColor: dark ? FColors.white : FColors.black,
            ),
            FBrandTitleTextWithVerifiedIcon(
                title: product.brand != null ? product.brand!.name : '',
                brandTextSize: TextSizes.medium),
          ],
        ),
        // const Gap(FSizes.spaceBtwItems),
      ],
    );
  }
}
