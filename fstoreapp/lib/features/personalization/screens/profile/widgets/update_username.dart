
import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/features/personalization/controllers/update_username_controller/update_username_controller.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/validators/validation.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UpdateUsername extends StatelessWidget {
  const UpdateUsername({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateUsernameController());
    return Scaffold(
      appBar: FAppBar(
        showBackArrow: true,
        title: Text(
          'Update User Name',
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
              'Your User Name will be update and will appear on several pages',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const Gap(FSizes.spaceBtwSections),

            /// Text Field and Button
            Form(
              key: controller.updateUsernameFormKey,
              child: TextFormField(
                controller: controller.userName,
                validator: (userName) =>
                    FValidator.validateEmptyString('UserName', userName),
                expands: false,
                decoration: InputDecoration(
                  labelText: controller.userName.text,
                  prefixIcon: const Icon(Iconsax.user),
                ),
              ),
            ),
            const Gap(FSizes.spaceBtwSections),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUsername(),
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
