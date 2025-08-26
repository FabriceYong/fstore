import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/data/models/user_model.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({super.key, required this.customer});

  final UserModel customer;

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
            'Customer Information',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap(FSizes.spaceBtwSections),

          // Personal Information Card
          Row(
            children: [
              FRoundedImage(
                imageType:customer.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
                padding: 0,
                backgroundColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.dark
                    : FColors.primaryBackground,
                imageUrl: customer.profilePicture.isNotEmpty ? customer.profilePicture : FImages.user,
              ),
              const Gap(FSizes.spaceBtwItems),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                     customer.fullName,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                     Text(
                      customer.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
          const Gap(FSizes.spaceBtwSections),

          // Meta Data
          Row(
            children: [
              const SizedBox(
                width: 120,
                child: Text('Username'),
              ),
              const Text(':'),
              const Gap(FSizes.spaceBtwItems / 2),
              Expanded(
                  child: Text(
                customer.userName,
                style: Theme.of(context).textTheme.titleMedium,
              ))
            ],
          ),
          const Gap(FSizes.spaceBtwItems),
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
              ))
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
                customer.phoneNumber,
                style: Theme.of(context).textTheme.titleMedium,
              ))
            ],
          ),
          const Gap(FSizes.spaceBtwItems),

          // Divider
          const Divider(),
          const Gap(FSizes.spaceBtwItems),

          // Additional Details
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last Order',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text(
                      '7 Days Ago, #[23578]',
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Average Order Value',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text('\$3435'),
                  ],
                ),
              )
            ],
          ),
          const Gap(FSizes.spaceBtwSections),

          // Additional Details Cont
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Registered',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(customer.formattedCreatedAtDate),
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email Marketing',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text('Subscribed')
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}
