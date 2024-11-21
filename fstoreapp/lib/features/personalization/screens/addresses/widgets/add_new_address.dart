import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/features/personalization/controllers/address_controller/address_controller.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/validators/validation.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
        appBar: const FAppBar(
          title: Text('Add New Address'),
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
            child: Form(
              key: controller.addressFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.name,
                    validator: (value) => FValidator.validateEmptyString('Name', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.user), labelText: 'Name'),
                  ),
                  const Gap(FSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.phoneNumber,
                    validator: (phoneNumber) => FValidator.validatePhoneNumber(phoneNumber),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.mobile),
                        labelText: 'Phone Number'),
                  ),
                  const Gap(FSizes.spaceBtwInputFields),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                            controller: controller.street,
                            validator: (value) => FValidator.validateEmptyString('Street', value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.building_31),
                            labelText: 'Street'),
                      )),
                      const Gap(FSizes.spaceBtwInputFields),
                      Expanded(
                        child: TextFormField(
                          controller: controller.postalCode,
                          validator: (value) => FValidator.validateEmptyString('Postal Code', value),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.code),
                              labelText: 'Postal Code'),
                        ),
                      )
                    ],
                  ),
                  const Gap(FSizes.spaceBtwInputFields),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                            controller: controller.city,
                            validator: (value) => FValidator.validateEmptyString('City', value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.building),
                            labelText: 'City'),
                      )),
                      const Gap(FSizes.spaceBtwInputFields),
                      Expanded(
                        child: TextFormField(
                          controller: controller.state,
                          validator: (value) => FValidator.validateEmptyString('State', value),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.activity),
                              labelText: 'State'),
                        ),
                      )
                    ],
                  ),
                  const Gap(FSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.country,
                    validator: (value) => FValidator.validateEmptyString('Country', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.global), labelText: 'Country'),
                  ),
                  const Gap(FSizes.defaultSpace),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () =>  controller.addNewAddress(), child: const Text('Save')),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
