import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/image_uploader.dart';
import 'package:f_store_dashboard/features/personalization/controllers/settngs_controller/settings_controller.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ImageAndMetaData extends StatelessWidget {
  const ImageAndMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return FRoundedContainer(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.black : FColors.white,
      padding: const EdgeInsets.symmetric(
          vertical: FSizes.lg, horizontal: FSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Obx(
                () => FImageUploader(
                  imageType: controller.settings.value.appLogo.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  right: 10,
                  bottom: 20,
                  left: null,
                  width: 200,
                  height: 200,
                  circular: true,
                  icon: Iconsax.camera,
                  loading: controller.loading.value,
                  onIconButtonPressed: () => controller.updateAppLogo(),
                  imageUrl: controller.settings.value.appLogo.isNotEmpty
                      ? controller.settings.value.appLogo
                      : FHelperFunctions.isDarkMode(context)
                          ? FImages.darkAppLogo
                          : FImages.lightAppLogo,
                ),
              ),
              const Gap(FSizes.spaceBtwItems),
              Obx(
                () => Text(
                  controller.settings.value.appName,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const Gap(FSizes.spaceBtwItems)
            ],
          )
        ],
      ),
    );
  }
}
