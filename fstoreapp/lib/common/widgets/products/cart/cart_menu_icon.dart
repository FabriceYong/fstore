import 'package:flutter/material.dart';
import 'package:fstoreapp/features/shop/controllers/product/cart_controller.dart';
import 'package:fstoreapp/features/shop/screens/cart/cart.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FCartCounterIcon extends StatelessWidget {
  const FCartCounterIcon({
    super.key,
    this.iconColor,
  });

  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const CartScreen()),
          icon: Icon(
            Iconsax.shopping_bag,
            color: iconColor,
          ),
        ),
        Positioned(
          right: 7,
          top: 7,
          child: Container(
            width: 17,
            height: 17,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Obx(
                () => Text(
                  controller.noOfCartItems.value.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: FColors.white, fontSizeFactor: .9),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
