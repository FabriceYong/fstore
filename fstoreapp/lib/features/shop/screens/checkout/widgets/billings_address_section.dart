import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/text/section_heading.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';

class FBillingAddressSection extends StatelessWidget {
  const FBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FSectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () {},
        ),
        Text(
          'Coding with F',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Gap(FSizes.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(
              Icons.phone,
              color: Colors.grey,
              size: 16,
            ),
            const Gap(FSizes.spaceBtwItems),
            Text(
              '(+123) 456 7890',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const Gap(FSizes.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(
              Icons.location_history,
              color: Colors.grey,
              size: 16,
            ),
            const Gap(FSizes.spaceBtwItems / 2),
            Expanded(
                child: Text(
              'South Liana, Maine 87695, USA',
              style: Theme.of(context).textTheme.bodyMedium,
              softWrap: true,
            ))
          ],
        )
      ],
    );
  }
}
