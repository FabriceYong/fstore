import 'package:f_store_dashboard/common/widgets/chips/choice_chip.dart';
import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/image_uploader.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FRoundedContainer(
      width: 500,
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.dark : Colors.white,
      padding: const EdgeInsets.all(FSizes.defaultSpace),
      child: Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          const Gap(FSizes.sm),
          Text(
            'Create New Brand',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap(FSizes.spaceBtwSections),

          // Form field
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Brand Name', prefixIcon: Icon(Iconsax.box)),
          ),
          const Gap(FSizes.spaceBtwInputFields),

          Text(
            'Select Categories',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Gap(FSizes.spaceBtwInputFields / 2),

          Wrap(
            spacing: FSizes.sm,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: FSizes.sm),
                child: FChoiceChip(
                    text: 'Tables', selected: true, onSelected: (value) {}),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: FSizes.sm),
                child: FChoiceChip(
                    text: 'Chairs', selected: false, onSelected: (value) {}),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: FSizes.sm),
                child: FChoiceChip(
                    text: 'Lamps', selected: false, onSelected: (value) {}),
              )
            ],
          ),
          const Gap(FSizes.spaceBtwInputFields * 2),
          FImageUploader(
            imageType: ImageType.asset,
            width: 80,
            height: 80,
            imageUrl: FImages.defaultImageIcon,
            onIconButtonPressed: () {},
          ),
          const Gap(FSizes.spaceBtwInputFields),

          CheckboxMenuButton(
              value: true,
              onChanged: (value) {},
              child: const Text('Featured')),
          const Gap(FSizes.spaceBtwInputFields * 2),

          SizedBox(
            width: double.infinity,
            child:
                ElevatedButton(onPressed: () {}, child: const Text('Create')),
          ),
          const Gap(FSizes.spaceBtwInputFields * 2)
        ],
      )),
    );
  }
}
