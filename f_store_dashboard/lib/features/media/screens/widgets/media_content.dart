import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/media/controllers/media_controller.dart';
import 'package:f_store_dashboard/features/media/screens/widgets/folder_dropdown.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class FMediaContentWidget extends StatelessWidget {
  const FMediaContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaController = MediaController.instance;
    return FRoundedContainer(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.black : Colors.white,
      padding: const EdgeInsets.all(FSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Media Image Header
          /// Folders Dropdown
          Row(
            children: [
              // Folders Dropdown
              Text(
                'Select Folder',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Gap(FSizes.spaceBtwItems),
              FFolderDropdownWidget(
                onChanged: (MediaCategory? category) {
                  if (category != null) {
                    mediaController.selectedPath.value = category;
                  }
                },
              )
            ],
          ),
          const Gap(FSizes.spaceBtwSections),

          /// Show Media
          /// Images
          Wrap(
            alignment: WrapAlignment.start,
            spacing: FSizes.spaceBtwItems / 2,
            runSpacing: FSizes.spaceBtwItems / 2,
            children: [
              FRoundedImage(
                imageType: ImageType.asset,
                width: 100,
                height: 100,
                padding: FSizes.sm,
                imageUrl: FImages.adidasLogo,
                overlayColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.grey
                    : FColors.black,
                backgroundColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.darkerGrey
                    : FColors.primaryBackground,
              ),
              FRoundedImage(
                imageType: ImageType.asset,
                width: 100,
                height: 100,
                padding: FSizes.sm,
                imageUrl: FImages.nikeLogo,
                overlayColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.grey
                    : FColors.black,
                backgroundColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.darkerGrey
                    : FColors.primaryBackground,
              ),
              FRoundedImage(
                imageType: ImageType.asset,
                width: 100,
                height: 100,
                padding: FSizes.sm,
                imageUrl: FImages.appleLogo,
                overlayColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.grey
                    : FColors.black,
                backgroundColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.darkerGrey
                    : FColors.primaryBackground,
              ),
              FRoundedImage(
                imageType: ImageType.asset,
                width: 100,
                height: 100,
                padding: FSizes.sm,
                imageUrl: FImages.ikeaLogo,
                overlayColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.grey
                    : FColors.black,
                backgroundColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.darkerGrey
                    : FColors.primaryBackground,
              ),
              FRoundedImage(
                imageType: ImageType.asset,
                width: 100,
                height: 100,
                padding: FSizes.sm,
                imageUrl: FImages.pumaLogo,
                overlayColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.grey
                    : FColors.black,
                backgroundColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.darkerGrey
                    : FColors.primaryBackground,
              ),
              FRoundedImage(
                imageType: ImageType.asset,
                width: 100,
                height: 100,
                padding: FSizes.sm,
                imageUrl: FImages.zaraLogo,
                overlayColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.grey
                    : FColors.black,
                backgroundColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.darkerGrey
                    : FColors.primaryBackground,
              ),
              FRoundedImage(
                imageType: ImageType.asset,
                width: 100,
                height: 100,
                padding: FSizes.sm,
                imageUrl: FImages.jordanLogo,
                overlayColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.grey
                    : FColors.black,
                backgroundColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.darkerGrey
                    : FColors.primaryBackground,
              )
            ],
          ),

          // const Gap(FSizes.spaceBtwSections),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: FSizes.spaceBtwSections),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: FSizes.buttonWidth,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(FSizes.sm))),
                      onPressed: () {},
                      icon: const Icon(Iconsax.arrow_down),
                      label: const Text('Load More')),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
