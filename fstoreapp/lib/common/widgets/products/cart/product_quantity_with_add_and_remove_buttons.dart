import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/icons/circular_icon.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class FProductQuantityWithAddAndRemoveButtons extends StatelessWidget {
  const FProductQuantityWithAddAndRemoveButtons(
      {super.key, required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: FSizes.md,
          backgroundColor: FHelperFunctions.isDarkMode(context)
              ? FColors.darkerGrey
              : FColors.light,
          color: FHelperFunctions.isDarkMode(context)
              ? FColors.white
              : FColors.black,
        ),
        const Gap(FSizes.spaceBtwItems),
        Text('$quantity', style: Theme.of(context).textTheme.titleSmall),
        const Gap(FSizes.spaceBtwItems),
        const FCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          backgroundColor: FColors.primary,
          size: FSizes.md,
          color: FColors.white,
        )
      ],
    );
  }
}
