import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/image_uploader.dart';
import 'package:f_store_dashboard/features/personalization/controllers/profile_controller/profile_controller.dart';
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
    final controller = ProfileController.instance;
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
                  imageType: controller.user.value.profilePicture.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  right: 10,
                  bottom: 20,
                  left: null,
                  width: 200,
                  height: 200,
                  circular: true,
                  loading: controller.isLoading.value,
                  icon: Iconsax.camera,
                  onIconButtonPressed: () => controller.updateProfilePicture(),
                  imageUrl: controller.user.value.profilePicture.isNotEmpty
                      ? controller.user.value.profilePicture
                      : FImages.user,
                ),
              ),
              const Gap(FSizes.spaceBtwItems),
              Obx(
                () => Text(
                  controller.user.value.fullName,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Obx(() => Text(controller.user.value.email)),
              const Gap(FSizes.spaceBtwItems)
            ],
          )
        ],
      ),
    );
  }
}
