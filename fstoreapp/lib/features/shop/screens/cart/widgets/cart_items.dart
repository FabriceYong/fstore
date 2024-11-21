import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/products/cart/cart_item.dart';
import 'package:fstoreapp/common/widgets/products/cart/product_quantity_with_add_and_remove_buttons.dart';
import 'package:fstoreapp/common/widgets/text/product_price_text.dart';
import 'package:fstoreapp/features/shop/controllers/product/cart_controller.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FCartItems extends StatelessWidget {
  const FCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        itemCount: controller.cartItems.length,
        separatorBuilder: (_, __) => const Gap(FSizes.spaceBtwItems),
        itemBuilder: (context, index) {
          return Obx(() {
            final item = controller.cartItems[index];
            return Column(
              children: [
                /// Cart Item
                FCartItem(cartItem: item),
                if (showAddRemoveButtons) const Gap(FSizes.spaceBtwItems),

                /// Add, Remove Buttons Row with Total Price
                if (showAddRemoveButtons)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Gap(70),

                          /// Add & Remove Buttons
                          FProductQuantityWithAddAndRemoveButtons(
                            quantity: item.quantity,
                            add: () => controller.addOneItemToCart(item),
                            remove: () =>
                                controller.removeOneItemFromCart(item),
                          ),
                        ],
                      ),
                      FProductPriceText(
                          price:
                              (item.price * item.quantity).toStringAsFixed(1))
                    ],
                  )
              ],
            );
          });
        },
      ),
    );
  }
}
