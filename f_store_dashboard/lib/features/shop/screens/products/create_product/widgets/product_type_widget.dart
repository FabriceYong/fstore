import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Product Type',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const Gap(FSizes.spaceBtwItems),
        // Radio Button Form Single Product Type
        RadioMenuButton(
            value: ProductType.single,
            groupValue: ProductType.single,
            onChanged: (value) {},
            child: const Text('Single')),

        // Radio Button For Variable   Product Type
        RadioMenuButton(
          value: ProductType.variable,
          groupValue: ProductType.single,
          onChanged: (value) {},
          child: const Text('Variable'),
        )
      ],
    );
  }
}
