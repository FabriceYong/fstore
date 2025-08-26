import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/personalization/controllers/settngs_controller/settings_controller.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());
    controller.appNameController.text = controller.settings.value.appName;
    controller.taxController.text =
        controller.settings.value.taxRate.toStringAsFixed(2);
    controller.shippingController.text =
        controller.settings.value.shippingCost.toStringAsFixed(2);
    controller.freeShippingThresholdController.text =
        controller.settings.value.freeShippingThreshold!.toStringAsFixed(2);
    return Column(
      children: [
        FRoundedContainer(
          backgroundColor: FHelperFunctions.isDarkMode(context)
              ? FColors.black
              : FColors.white,
          padding: const EdgeInsets.symmetric(
              vertical: FSizes.lg, horizontal: FSizes.md),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'App Settings',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Gap(FSizes.spaceBtwSections),

                TextFormField(
                  controller: controller.appNameController,
                  validator: (value) =>
                      FValidator.validateEmptyText('App Name', value),
                  decoration: const InputDecoration(
                    labelText: 'App Name',
                    hintText: 'App Name',
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                const Gap(FSizes.spaceBtwInputFields),

                // Tax and Shipping Cost
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.taxController,
                        validator: (value) =>
                            FValidator.validateEmptyText('Tax %', value),
                        decoration: const InputDecoration(
                          hintText: 'Tax %',
                          labelText: 'Tax Rate (%)',
                          prefixIcon: Icon(Iconsax.tag),
                        ),
                      ),
                    ),
                    const Gap(FSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.shippingController,
                        validator: (value) => FValidator.validateEmptyText(
                            'Shipping Cost', value),
                        decoration: const InputDecoration(
                          hintText: 'Shipping Cost',
                          labelText: 'Shipping Cost (\$)',
                          prefixIcon: Icon(Iconsax.ship),
                        ),
                      ),
                    ),
                    const Gap(FSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.freeShippingThresholdController,
                        validator: (value) => FValidator.validateEmptyText(
                            'Free Shipping Threshold (\$)', value),
                        decoration: const InputDecoration(
                          hintText: 'Free Shipping Threshold (\$)',
                          labelText: 'Free Shipping Threshold (\$)',
                          prefixIcon: Icon(Iconsax.ship),
                        ),
                      ),
                    )
                  ],
                ),

                const Gap(FSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                        onPressed: controller.loading.value
                            ? () {}
                            : () => controller.updateSettingsInformation(),
                        child: controller.loading.value
                            ? const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: FColors.white,
                              )
                            : const Text('Update App Settings')),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
