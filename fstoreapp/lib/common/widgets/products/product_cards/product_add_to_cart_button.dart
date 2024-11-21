import 'package:flutter/material.dart';
import 'package:fstoreapp/features/shop/controllers/product/cart_controller.dart';
import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:fstoreapp/features/shop/screens/product_details/product_details.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/enums.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductCartAddToCartButton extends StatelessWidget {
  const ProductCartAddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return InkWell(
      onTap: () {
        // If the product have variation then show the product Details for variation selection
        //Else add product to the cart
        if (product.productType == ProductType.single.toString()) {
          final cartItem = controller.convertToCartItem(product, 1);
          controller.addOneItemToCart(cartItem);
        } else {
          Get.to(() => ProductDetails(product: product)); 
        }
      },
      child: Obx(
        () {
          final productQuantityInCart =
              controller.getProductQuantityInCart(product.id);
          return Container(
            decoration: BoxDecoration(
              color: productQuantityInCart > 0 ? FColors.primary : FColors.dark,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(FSizes.cardRadiusLg),
                bottomRight: Radius.circular(FSizes.productImageRadius),
              ),
            ),
            child: SizedBox(
              width: FSizes.iconLg * 1.2,
              height: FSizes.iconLg * 1.2,
              child: Center(
                child: productQuantityInCart > 0
                    ? Text(
                        productQuantityInCart.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: FColors.white),
                      )
                    : const Icon(
                        Iconsax.add,
                        color: FColors.white,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
