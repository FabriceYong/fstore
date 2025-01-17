import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/image_uploader.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages(
      {super.key,
      this.onTapToAddImages,
      this.onTapToRemoveImage,
      required this.additionalProductImageUrls});
  final void Function()? onTapToAddImages;
  final void Function(int index)? onTapToRemoveImage;
  final RxList<String> additionalProductImageUrls;

  @override
  Widget build(BuildContext context) {
    return FRoundedContainer(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.black : FColors.white,
      padding: const EdgeInsets.all(FSizes.md),
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            // Section to add addtional Product Images
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: onTapToAddImages,
                child: FRoundedContainer(
                  padding: const EdgeInsets.all(FSizes.sm),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          FImages.defaultMultiImageIcon,
                          width: 50,
                          height: 50,
                        ),
                        const Text('Add Additional Product Images')
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Section to display Uploaded Images
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 80,
                      child: _uploadImagesOrEmptyList(),
                    ),
                  ),
                  const Gap(FSizes.spaceBtwItems / 2),

                  // Add More Images Button
                  FRoundedContainer(
                    width: 80,
                    height: 80,
                    showBorder: true,
                    borderColor: FHelperFunctions.isDarkMode(context)
                        ? FColors.darkerGrey
                        : FColors.grey,
                    backgroundColor: FHelperFunctions.isDarkMode(context)
                        ? FColors.black
                        : FColors.white,
                    onTap: onTapToAddImages,
                    child: const Center(
                      child: Icon(Iconsax.add),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget to Display Either Uploaded Images or Empty List
  Widget _uploadImagesOrEmptyList() {
    return additionalProductImageUrls.isNotEmpty
        ? _uploadedImages()
        : _emptyList();
  }

  Widget _uploadedImages() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: additionalProductImageUrls.length,
      separatorBuilder: (_, __) => const Gap(FSizes.spaceBtwItems / 2),
      itemBuilder: (context, index) {
        final imageUrl = additionalProductImageUrls[index];
        return FImageUploader(
          imageType: ImageType.network,
          width: 80,
          height: 80,
          top: 0,
          right: 0,
          left: null,
          bottom: null,
          imageUrl: imageUrl,
          icon: Iconsax.trash,
          onIconButtonPressed: () => onTapToRemoveImage!(index),
        );
      },
    );
  }

  // Widget to Display Empty List Placeholder
  Widget _emptyList() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      separatorBuilder: (_, __) => const Gap(FSizes.spaceBtwItems / 2),
      itemBuilder: (context, index) => FRoundedContainer(
        backgroundColor: FHelperFunctions.isDarkMode(context)
            ? FColors.darkerGrey
            : FColors.primaryBackground,
        width: 80,
        height: 80,
      ),
    );
  }
}
