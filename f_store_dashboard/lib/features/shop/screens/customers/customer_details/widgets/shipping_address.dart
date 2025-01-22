import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return FRoundedContainer(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.black : FColors.white,
      padding: const EdgeInsets.all(FSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping Address',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap(FSizes.spaceBtwSections),

          // Meta Data
          Row(
            children: [
              const SizedBox(
                width: 120,
                child: Text('Name'),
              ),
              const Text(':'),
              const Gap(FSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  'Coding With F',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
            ],
          ),
          const Gap(FSizes.spaceBtwItems),

          // Address
          Row(
            children: [
              const SizedBox(
                width: 120,
                child: Text('Country'),
              ),
              const Text(':'),
              const Gap(FSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  'United Kingdom',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
            ],
          ),
          const Gap(FSizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(
                width: 120,
                child: Text('Phone Number'),
              ),
              const Text(':'),
              const Gap(FSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  '+44-568-25885',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
            ],
          ),
          const Gap(FSizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(
                width: 120,
                child: Text('Address'),
              ),
              const Text(':'),
              const Gap(FSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  '123, Main St, London',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
