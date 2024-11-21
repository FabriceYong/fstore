import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/text/section_heading.dart';
import 'package:fstoreapp/features/personalization/controllers/address_controller/address_controller.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';

class FBillingAddressSection extends StatelessWidget {
  const FBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FSectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () => controller.selectNewAddressPopup(context),
        ),
        controller.selectedAddress.value.id.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.selectedAddress.value.name,
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
                        controller.selectedAddress.value.phoneNumber,
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
                        controller.selectedAddress.value.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                        softWrap: true,
                      ))
                    ],
                  )
                ],
              )
            : Text(
                'Select Address',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
      ],
    );
  }
}
