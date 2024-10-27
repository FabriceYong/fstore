import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/icons/circular_icon.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class FBottomAddToCart extends StatelessWidget {
  const FBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const FCircularIcon(
                icon: Iconsax.minus,
                backgroundColor: FColors.darkGrey,
                width: 40,
                height: 40,
                color: FColors.white,
              ),
              const Gap(FSizes.spaceBtwItems),
              Text(
                '2',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Gap(FSizes.spaceBtwItems),
              const FCircularIcon(
                icon: Iconsax.add,
                width: 40,
                height: 40,
                backgroundColor: FColors.primary,
                color: FColors.white,
              )
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(FSizes.md),
                  backgroundColor: FColors.black,
                  side: const BorderSide(color: FColors.black)),
              onPressed: () {},
              child: const Text('Add to Cart'))
        ],
      ),
    );
  }
}
