import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fstoreapp/common/widgets/text/section_heading.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';

class FBillingPaymentSection extends StatelessWidget {
  const FBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        FSectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () {},
        ),
        const Gap(FSizes.spaceBtwItems / 2),
        Row(
          children: [
            FRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? FColors.light : FColors.white,
              padding: const EdgeInsets.all(FSizes.sm),
              child: Image.asset(
                FImages.paypal,
                fit: BoxFit.contain,
              ),
            ),
            const Gap(FSizes.spaceBtwItems),
            Text('Paypal', style: Theme.of(context).textTheme.bodyLarge)
          ],
        )
      ],
    );
  }
}
