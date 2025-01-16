import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          color: FColors.primaryBackground,
        ),
        const Gap(FSizes.spaceBtwSections),

        Text(
          'Add Product Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Gap(FSizes.spaceBtwItems),

        // Form to Add New Attribute
        Form(
          child: FDeviceUtils.isDesktopScreen(context)
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Attribute Name
                    Expanded(child: _buildAttributeName()),
                    const Gap(FSizes.spaceBtwItems),
                    // Attribute Value
                    Expanded(flex: 2, child: _buildAttributeTextField()),
                    const Gap(FSizes.spaceBtwItems),

                    // Add Attribute Button
                    Expanded(child: _buildAddAttributeButton())
                  ],
                )
              : Column(
                  children: [
                    // Attribute Name
                    _buildAttributeName(),
                    const Gap(FSizes.spaceBtwItems),

                    // Attribute Value
                    _buildAttributeTextField(),
                    const Gap(FSizes.spaceBtwItems),

                    // Add Attribute Button
                    _buildAddAttributeButton()
                  ],
                ),
        ),
        const Gap(FSizes.spaceBtwSections),

        // List of Added Attributes
        Text(
          'All Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Gap(FSizes.spaceBtwItems),

        // Display added attributes in a Rounded Container
        FRoundedContainer(
          backgroundColor: FHelperFunctions.isDarkMode(context)
              ? FColors.dark
              : FColors.primaryBackground,
          padding: const EdgeInsets.all(FSizes.md),
          child: Column(
            children: [
              buildAttributesList(context),
              buildEmptyAttribute(),
            ],
          ),
        ),
        const Gap(FSizes.spaceBtwSections),

        Center(
          child: SizedBox(
            width: 200,
            child: ElevatedButton.icon(
              onPressed: () {},
              label: const Text('Generate Variations'),
              icon: const Icon(Iconsax.activity),
            ),
          ),
        )
      ],
    );
  }

  // Build TextFormField for Attribute Name
  TextFormField _buildAttributeName() {
    return TextFormField(
      validator: (value) =>
          FValidator.validateEmptyText('Attribute Name', value),
      decoration: const InputDecoration(
          labelText: 'Attribute Text', hintText: 'Color, Sizes, Material'),
    );
  }

// Build TextFormField for attribute values
  SizedBox _buildAttributeTextField() {
    return SizedBox(
      height: 80,
      child: TextFormField(
        expands: true,
        maxLines: null,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator: (value) =>
            FValidator.validateEmptyText('Attributes Field', value),
        decoration: const InputDecoration(
            labelText: 'Attributes',
            hintText:
                'Add Attributes Separated By | Example: Green | Blue | Yellow'),
      ),
    );
  }

  // Build Add Button to add attribute
  SizedBox _buildAddAttributeButton() {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        icon: const Icon(Iconsax.add),
        onPressed: () {},
        label: const Text('Add'),
        style: ElevatedButton.styleFrom(
          foregroundColor: FColors.black,
          backgroundColor: FColors.secondary,
          side: const BorderSide(color: FColors.secondary),
        ),
      ),
    );
  }

  ListView buildAttributesList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 3,
      separatorBuilder: (_, __) => const Gap(FSizes.spaceBtwItems),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: FHelperFunctions.isDarkMode(context)
                ? FColors.black
                : FColors.white,
            borderRadius: BorderRadius.circular(FSizes.borderRadiusLg),
          ),
          child: ListTile(
            title: const Text('Color'),
            subtitle: const Text('Green, Blue, Pink'),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Iconsax.trash,
                color: FColors.error,
              ),
            ),
          ),
        );
      },
    );
  }

  Column buildEmptyAttribute() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FRoundedImage(
              imageType: ImageType.asset,
              width: 150,
              height: 80,
              imageUrl: FImages.defaultAttributeColorsImageIcon,
            )
          ],
        ),
      ],
    );
  }
}
