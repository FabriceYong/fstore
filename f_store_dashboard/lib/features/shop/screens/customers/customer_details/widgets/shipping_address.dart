import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/shop/controllers/customer_controller/customer_details_controller.dart';
import 'package:f_store_dashboard/features/shop/models/addresses_model/address_model.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/loaders/normal_animated_loader.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerDetailsController());
    controller.getCustomerAddresses();
    return Obx((){
      if(controller.addressLoading.value) return const FLoaderAnimation();

      AddressModel selectedAddress = AddressModel.empty();
      if(controller.customer.value.addresses != null) {
        if(controller.customer.value.addresses!.isNotEmpty){
          selectedAddress = controller.customer.value.addresses!.where((element) => element.selectedAddress).single;
        }
      }
      return FRoundedContainer(
        backgroundColor:
            FHelperFunctions.isDarkMode(context) ? FColors.black : FColors.white,
        padding: const EdgeInsets.all(FSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Address',
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
                    selectedAddress.name,
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
                    selectedAddress.country,
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
                    selectedAddress.phoneNumber,
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
                   selectedAddress.id.isNotEmpty ? selectedAddress.toString() : '',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              ],
            )
          ],
        ),
      );
    }
    );
  }
}
