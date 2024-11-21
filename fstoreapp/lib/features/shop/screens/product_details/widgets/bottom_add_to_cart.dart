import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/icons/circular_icon.dart';
import 'package:fstoreapp/features/shop/controllers/product/cart_controller.dart';
import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FBottomAddToCart extends StatelessWidget {
  const FBottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddProductCount(product);
    final dark = FHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: FSizes.defaultSpace, vertical: FSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? FColors.darkerGrey : FColors.light,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(FSizes.cardRadiusLg),
            topRight: Radius.circular(FSizes.cardRadiusLg)),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                FCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: FColors.darkGrey,
                  width: 40,
                  height: 40,
                  color: FColors.white,
                  onPressed: () => controller.productQuantityInCart.value < 1
                      ? null
                      : controller.productQuantityInCart.value -= 1,
                ),
                const Gap(FSizes.spaceBtwItems),
                Text(
                  '${controller.productQuantityInCart.value}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Gap(FSizes.spaceBtwItems),
                FCircularIcon(
                  icon: Iconsax.add,
                  width: 40,
                  height: 40,
                  backgroundColor: FColors.primary,
                  color: FColors.white,
                  onPressed: () => controller.productQuantityInCart.value += 1,
                )
              ],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(FSizes.md),
                    backgroundColor: FColors.black,
                    side: const BorderSide(color: FColors.black)),
                onPressed: controller.productQuantityInCart.value < 1
                    ? null
                    : () => controller.addToCart(product),
                child: const Text('Add to Cart')),
          ],
        ),
      ),
    );
  }
}
