import 'package:flutter/material.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';

class FBillingAmountSection extends StatelessWidget {
  const FBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// SubTotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subtotal',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '\$3400',
              style: Theme.of(context).textTheme.labelLarge,
            )
          ],
        ),
        const Gap(FSizes.spaceBtwItems / 2),

        /// Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Shipping Fee',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '\$6.0',
              style: Theme.of(context).textTheme.labelLarge,
            )
          ],
        ),
        const Gap(FSizes.spaceBtwItems / 2),

        /// Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order Total',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '\$3506.56',
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ],
    );
  }
}
