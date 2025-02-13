import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/shop/controllers/banners_controller/create_banner_controller.dart';
import 'package:f_store_dashboard/routes/app_screens.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBannerController());
    return FRoundedContainer(
      width: 500,
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.black : Colors.white,
      padding: const EdgeInsets.all(FSizes.defaultSpace),
      child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              const Gap(FSizes.sm),
              Text(
                'Create New Banner',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Gap(FSizes.spaceBtwSections),

              /// Image Uploader and Featured Checkbox
              Obx(
                () => Column(
                  children: [
                    InkWell(
                      child: FRoundedImage(
                        imageType: controller.imageUrl.value.isNotEmpty
                            ? ImageType.network
                            : ImageType.asset,
                        width: 400,
                        height: 200,
                        backgroundColor: FHelperFunctions.isDarkMode(context)
                            ? FColors.black
                            : FColors.grey,
                        imageUrl: controller.imageUrl.value.isNotEmpty
                            ? controller.imageUrl.value
                            : FImages.defaultImageIcon,
                      ),
                    ),
                    const Gap(FSizes.spaceBtwItems),
                    TextButton(
                        onPressed: () => controller.pickImage(),
                        child: const Text('Select Image'))
                  ],
                ),
              ),
              const Gap(FSizes.spaceBtwInputFields),

              Text(
                'Make Your Banner Active or InActive',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Obx(
                () => CheckboxMenuButton(
                    value: controller.isActive.value,
                    onChanged: (value) =>
                        controller.isActive.value = value ?? false,
                    child: const Text('Active')),
              ),
              const Gap(FSizes.spaceBtwInputFields),

              Obx(
                () => DropdownButton<String>(
                  value: controller.targetScreen.value,
                  onChanged: (String? newValue) =>
                      controller.targetScreen.value = newValue!,
                  items: FAppScreens.allAppScreenItems
                      .map<DropdownMenuItem<String>>(
                        (screen) => DropdownMenuItem<String>(
                          value: screen,
                          child: Text(screen),
                        ),
                      )
                      .toList(),
                ),
              ),
              const Gap(FSizes.spaceBtwInputFields * 2),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.createBanner(),
                    child: const Text('Create')),
              ),
              const Gap(FSizes.spaceBtwInputFields * 2)
            ],
          )),
    );
  }
}
