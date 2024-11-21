import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fstoreapp/data/models/address_model/address_model.dart';
import 'package:fstoreapp/features/personalization/controllers/address_controller/address_controller.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FSingleAddress extends StatelessWidget {
  const FSingleAddress({super.key, required this.address, required this.onTap});

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;
      return InkWell(
        onTap: onTap,
        child: FRoundedContainer(
          width: double.infinity,
          showBorder: true,
          padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
          backgroundColor: selectedAddress
              ? FColors.primary.withOpacity(.5)
              : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : FHelperFunctions.isDarkMode(context)
                  ? FColors.darkerGrey
                  : FColors.grey,
          margin: const EdgeInsets.only(bottom: FSizes.spaceBtwItems),
          child: Stack(
            children: [
              Positioned(
                right: 5,
                child: Icon(
                  selectedAddress ? Iconsax.tick_circle5 : null,
                  color: FHelperFunctions.isDarkMode(context)
                      ? FColors.light.withOpacity(.7)
                      : FColors.dark.withOpacity(.7),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Gap(FSizes.sm / 2),
                  Text(
                    address.formattedPhoneNo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(FSizes.sm / 2),
                  Text(
                    address.toString(),
                    softWrap: true,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
