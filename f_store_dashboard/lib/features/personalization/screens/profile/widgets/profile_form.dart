import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/personalization/controllers/profile_controller/profile_controller.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProfileController.instance;
    controller.firstName.text = controller.user.value.firstName;
    controller.lastName.text = controller.user.value.lastName;
    controller.email.text = controller.user.value.email;
    controller.phoneNumber.text = controller.user.value.phoneNumber;
    return Column(
      children: [
        FRoundedContainer(
          backgroundColor: FHelperFunctions.isDarkMode(context)
              ? FColors.black
              : FColors.white,
          padding: const EdgeInsets.symmetric(
              vertical: FSizes.lg, horizontal: FSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Gap(FSizes.spaceBtwSections),

              // First and Last Names
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (value) => FValidator.validateEmptyText(
                                'First Name', value),
                            controller: controller.firstName,
                            decoration: const InputDecoration(
                                hintText: 'First Name',
                                labelText: 'First Name',
                                prefixIcon: Icon(Iconsax.user)),
                          ),
                        ),
                        const Gap(FSizes.spaceBtwInputFields),
                        Expanded(
                          child: TextFormField(
                            validator: (value) => FValidator.validateEmptyText(
                                'Last Name', value),
                            controller: controller.lastName,
                            decoration: const InputDecoration(
                                hintText: 'Last Name',
                                labelText: 'Last Name',
                                prefixIcon: Icon(Iconsax.user)),
                          ),
                        ),
                      ],
                    ),
                    const Gap(FSizes.spaceBtwInputFields),

                    // Email and Phone
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (value) =>
                                FValidator.validateEmail(value),
                            controller: controller.email,
                            decoration: const InputDecoration(
                                hintText: 'Email',
                                labelText: 'Email',
                                prefixIcon: Icon(
                                  Iconsax.direct,
                                ),
                                enabled: false),
                          ),
                        ),
                        const Gap(FSizes.spaceBtwInputFields),
                        Expanded(
                          child: TextFormField(
                            validator: (value) =>
                                FValidator.validatePhoneNumber(value),
                            controller: controller.phoneNumber,
                            decoration: const InputDecoration(
                              hintText: 'Phone Number',
                              labelText: 'Phone Number',
                              prefixIcon: Icon(Iconsax.mobile),
                            ),
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
                child: Obx(
                  () => ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? () {}
                          : () => controller.updateUserProfile(),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: FColors.white,
                            )
                          : const Text('Update Profile')),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
