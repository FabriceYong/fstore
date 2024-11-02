
import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/products/cart/cart_item.dart';
import 'package:fstoreapp/common/widgets/products/cart/product_quantity_with_add_and_remove_buttons.dart';
import 'package:fstoreapp/common/widgets/text/product_price_text.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';

class FCartItems extends StatelessWidget {
  const FCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 8,
      separatorBuilder: (_, __) => const Gap(FSizes.spaceBtwItems),
      itemBuilder: (context, index) {
        return Column(
          children: [
            /// Cart Item
            const FCartItem(),
            if (showAddRemoveButtons) const Gap(FSizes.spaceBtwItems),

            /// Add, Remove Buttons Row with Total Price
            if (showAddRemoveButtons)
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Gap(70),

                      /// Add & Remove Buttons
                      FProductQuantityWithAddAndRemoveButtons(
                        quantity: 5,
                      ),
                    ],
                  ),
                  FProductPriceText(price: '840')
                ],
              )
          ],
        );
      },
    );
  }
}
