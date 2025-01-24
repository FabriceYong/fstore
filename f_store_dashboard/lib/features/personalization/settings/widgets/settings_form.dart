import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FRoundedContainer(
          backgroundColor: FHelperFunctions.isDarkMode(context)
              ? FColors.black
              : FColors.white,
          padding: const EdgeInsets.symmetric(
              vertical: FSizes.lg, horizontal: FSizes.md),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'App Settings',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Gap(FSizes.spaceBtwSections),

                TextFormField(
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
                        // validator: (value) => FValidator.validateEmptyText(
                        //     'Tax %', value),
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
                        // validator: (value) => FValidator.validateEmptyText(
                        //     'Last Name', value),
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
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text('Update Profile')),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
