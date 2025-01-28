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

class ImageAndMetaData extends StatelessWidget {
  const ImageAndMetaData({super.key});

  @override
  Widget build(BuildContext context) {
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
              FImageUploader(
                imageType: ImageType.asset,
                right: 10,
                bottom: 20,
                left: null,
                width: 200,
                height: 200,
                circular: true,
                icon: Iconsax.camera,
                imageUrl: FHelperFunctions.isDarkMode(context)
                    ? FImages.lightAppLogo
                    : FImages.darkAppLogo,
              ),
              const Gap(FSizes.spaceBtwItems),
              Text(
                'FSTORE',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Gap(FSizes.spaceBtwItems)
            ],
          )
        ],
      ),
    );
  }
}
