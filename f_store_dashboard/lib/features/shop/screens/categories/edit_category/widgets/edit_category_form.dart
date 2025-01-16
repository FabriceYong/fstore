import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/image_uploader.dart';
import 'package:f_store_dashboard/features/shop/models/category_model/category_model.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({super.key, required this.category});

  final CategoryModel category;

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
              'Update Category',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const Gap(FSizes.spaceBtwInputFields * 2),
            TextFormField(
              controller: TextEditingController(),
              validator: (value) => FValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                labelText: 'Category Name',
                prefixIcon: Icon(Iconsax.category),
              ),
            ),

            const Gap(FSizes.spaceBtwInputFields),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                  labelText: 'Parent Category',
                  hintText: 'Parent Category',
                  prefixIcon: Icon(Iconsax.bezier)),
              items: const [
                DropdownMenuItem(
                  value: '',
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [Text('item.name')],
                  ),
                ),
              ],
              onChanged: (value) {},
            ),

            const Gap(FSizes.spaceBtwSections),
            FImageUploader(
                width: 80,
                height: 80,
                imageUrl: FImages.defaultImageIcon,
                imageType: ImageType.asset,
                onIconButtonPressed: () {}),

            const Gap(FSizes.spaceBtwSections),

            CheckboxMenuButton(
              value: true,
              onChanged: (value) {},
              child: const Text('Featured'),
            ),
            const Gap(FSizes.spaceBtwInputFields),

            SizedBox(
              width: double.infinity,
              child:
                  ElevatedButton(onPressed: () {}, child: const Text('Update')),
            ),

            const Gap(FSizes.spaceBtwInputFields)
          ],
        ),
      ),
    );
  }
}