import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/shop/models/banner_model/banner_model.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditBannerForm extends StatelessWidget {
  const EditBannerForm({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return FRoundedContainer(
      width: 500,
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.black : Colors.white,
      padding: const EdgeInsets.all(FSizes.defaultSpace),
      child: Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          const Gap(FSizes.sm),
          Text(
            'Update Banner',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap(FSizes.spaceBtwSections),

          /// Image Uploader and Featured Checkbox
          Column(
            children: [
              InkWell(
                child: FRoundedImage(
                  imageType: ImageType.asset,
                  width: 400,
                  height: 200,
                  backgroundColor: FHelperFunctions.isDarkMode(context)
                      ? FColors.black
                      : FColors.grey,
                  imageUrl: FImages.defaultImageIcon,
                ),
              ),
              const Gap(FSizes.spaceBtwItems),
              TextButton(onPressed: () {}, child: const Text('Select Image'))
            ],
          ),
          const Gap(FSizes.spaceBtwInputFields),

          Text(
            'Make Your Banner Active or InActive',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          CheckboxMenuButton(
              value: true, onChanged: (value) {}, child: const Text('Active')),
          const Gap(FSizes.spaceBtwInputFields),

          DropdownButton<String>(
            value: 'search',
            onChanged: (String? newValue) {},
            items: const [
              DropdownMenuItem<String>(
                value: 'home',
                child: Text('Home'),
              ),
              DropdownMenuItem<String>(
                value: 'search',
                child: Text('Search'),
              )
            ],
          ),
          const Gap(FSizes.spaceBtwInputFields * 2),

          SizedBox(
            width: double.infinity,
            child:
                ElevatedButton(onPressed: () {}, child: const Text('Update')),
          ),
          const Gap(FSizes.spaceBtwInputFields * 2)
        ],
      )),
    );
  }
}
