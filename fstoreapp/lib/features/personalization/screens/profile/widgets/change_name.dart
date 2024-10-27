import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/features/personalization/controllers/update_name_controller/update_name_controller.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/validators/validation.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: FAppBar(
        showBackArrow: true,
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(
              'User real name for easy verification. this name will appear on several pages',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const Gap(FSizes.spaceBtwSections),

            /// Text Field and Button
            Form(
              key: controller.updateNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (firstName) =>
                        FValidator.validateEmptyString('First Name', firstName),
                    expands: false,
                    decoration: InputDecoration(
                      labelText: controller.firstName.text,
                      prefixIcon: const Icon(Iconsax.user),
                    ),
                  ),
                  const Gap(FSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (lastName) =>
                        FValidator.validateEmptyString('Last Name', lastName),
                    expands: false,
                    decoration: InputDecoration(
                      labelText: controller.lastName.text,
                      prefixIcon: const Icon(Iconsax.user),
                    ),
                  )
                ],
              ),
            ),
            const Gap(FSizes.spaceBtwSections),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateName(),
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
