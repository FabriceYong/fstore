import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/shop/models/order_model/order_model.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrderCustomer extends StatelessWidget {
  const OrderCustomer({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Information
        FRoundedContainer(
          backgroundColor: FHelperFunctions.isDarkMode(context)
              ? FColors.black
              : FColors.white,
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Gap(FSizes.spaceBtwSections),
              Row(
                children: [
                  FRoundedImage(
                    imageType: ImageType.asset,
                    imageUrl: FImages.user,
                    padding: 0,
                    backgroundColor: FHelperFunctions.isDarkMode(context)
                        ? FColors.dark
                        : FColors.primaryBackground,
                  ),
                  const Gap(FSizes.spaceBtwItems),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Coding With F',
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Text(
                          'jamesbond@gmail.com',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        const Gap(FSizes.spaceBtwSections),
        SizedBox(
          width: double.infinity,
          child: FRoundedContainer(
            backgroundColor: FHelperFunctions.isDarkMode(context)
                ? FColors.black
                : FColors.white,
            padding: const EdgeInsets.all(FSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Person',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Gap(FSizes.spaceBtwSections),
                Text(
                  'Coding With F',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Gap(FSizes.spaceBtwItems / 2),
                Text(
                  'jamesbond@gmail.com',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Gap(FSizes.spaceBtwItems / 2),
                Text(
                  '+44 *** *****',
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
          ),
        ),
        const Gap(FSizes.spaceBtwSections),

        SizedBox(
          width: double.infinity,
          child: FRoundedContainer(
            backgroundColor: FHelperFunctions.isDarkMode(context)
                ? FColors.black
                : FColors.white,
            padding: const EdgeInsets.all(FSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping Address',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Gap(FSizes.spaceBtwSections),
                Text(
                  'James Bond',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Gap(FSizes.spaceBtwItems / 2),
                Text(
                  '63 Trafalga Square London, United Kingdom',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        const Gap(FSizes.spaceBtwSections),

        SizedBox(
          width: double.infinity,
          child: FRoundedContainer(
            backgroundColor: FHelperFunctions.isDarkMode(context)
                ? FColors.black
                : FColors.white,
            padding: const EdgeInsets.all(FSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Billing Address',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Gap(FSizes.spaceBtwSections),
                Text(
                  'James Bond',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Gap(FSizes.spaceBtwItems / 2),
                Text(
                  '63 Trafalga Square London, United Kingdom',
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
