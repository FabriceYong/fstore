import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class FOrderListItems extends StatelessWidget {
  const FOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 6,
      separatorBuilder: (_, __) => const Gap(FSizes.spaceBtwItems),
      itemBuilder: (context, index) => FRoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(FSizes.md),
        backgroundColor: dark ? FColors.darkerGrey : FColors.grey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                /// Icon
                const Icon(Iconsax.ship),
                const Gap(FSizes.spaceBtwItems / 2),

                /// Status & DAte
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Processing',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: FColors.primary, fontWeightDelta: 1),
                      ),
                      Text(
                        '27 Nov, 2024',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),

                /// Icon
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.arrow_right_34,
                      size: FSizes.iconSm,
                    ))
              ],
            ),
            const Gap(FSizes.spaceBtwItems / 2),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      /// Icon
                      const Icon(Iconsax.tag),
                      const Gap(FSizes.spaceBtwItems / 2),

                      /// Status & DAte
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              '[#235er5]',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      /// Icon
                      const Icon(Iconsax.calendar),
                      const Gap(FSizes.spaceBtwItems / 2),

                      /// Status & DAte
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shipping Date',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              '02 Feb, 2025',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
