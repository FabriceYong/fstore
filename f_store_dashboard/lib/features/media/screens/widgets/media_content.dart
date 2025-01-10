import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/media/controllers/media_controller.dart';
import 'package:f_store_dashboard/features/media/models/image_model.dart';
import 'package:f_store_dashboard/features/media/screens/widgets/folder_dropdown.dart';
import 'package:f_store_dashboard/features/media/screens/widgets/image_details.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/loaders/animation_loader.dart';
import 'package:f_store_dashboard/utils/loaders/normal_animated_loader.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FMediaContentWidget extends StatelessWidget {
  FMediaContentWidget(
      {super.key,
      required this.allowSelection,
      required this.allowMultipleSelection,
      this.alreadySelectedUrls,
      this.onImageSelected});

  final bool allowSelection;
  final bool allowMultipleSelection;
  final List<String>? alreadySelectedUrls;
  final List<ImageModel> selectedImages = [];
  final Function(List<ImageModel> selectedImages)? onImageSelected;

  @override
  Widget build(BuildContext context) {
    bool loadedPreviousSelection = false;
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                        // Get Media Category Images
                        mediaController.getMediaImages();
                      }
                    },
                  )
                ],
              ),
              if (allowSelection) buildAddSelectedImagesButton()
            ],
          ),
          const Gap(FSizes.spaceBtwSections),

          /// Show Media
          /// Images
          Obx(() {
            // Get selected Folder Images
            final List<ImageModel> images =
                _getSelectedFolderImages(mediaController);

            // Load Selected images from the Already Selected Images only once otherwise
            // on Obx() rebuild UI first images will be selected and then will auto uncheck
            if (!loadedPreviousSelection) {
              if (alreadySelectedUrls != null &&
                  alreadySelectedUrls!.isNotEmpty) {
                // Convert alreadySelectedUrls to a Set for faster lookup
                final selectedUrlsSet = Set<String>.from(alreadySelectedUrls!);

                for (var image in images) {
                  image.isSelected.value = selectedUrlsSet.contains(image.url);
                  if (image.isSelected.value) {
                    selectedImages.add(image);
                  }
                }
              } else {
                // if alreadySelectedUrls is null or empty, set all images to not selected
                for (var image in images) {
                  image.isSelected.value = false;
                }
              }
              loadedPreviousSelection = true;
            }

            // Start Loader
            if (mediaController.loading.value) // && images.isNotEmpty
              return const FLoaderAnimation();

            // If Images returns an empty list
            if (images.isEmpty)
              return _buildEmptyImagesAnimationWidget(context);

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                    alignment: WrapAlignment.start,
                    spacing: FSizes.spaceBtwItems / 2,
                    runSpacing: FSizes.spaceBtwItems / 2,
                    children: images
                        .map(
                          (image) => GestureDetector(
                            onTap: () => Get.dialog(ImagePopUp(image: image),
                                barrierDismissible: true),
                            child: SizedBox(
                              width: 140,
                              height: 180,
                              child: Column(
                                children: [
                                  allowSelection
                                      ? _buildListWithCheckbox(context, image)
                                      : _buildSimpleList(image, context),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: FSizes.sm),
                                      child: Text(
                                        image.filename,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList()),

                // const Gap(FSizes.spaceBtwSections),
                if (!mediaController.loading.value)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: FSizes.spaceBtwSections),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: FSizes.buttonWidth,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(FSizes.sm))),
                            onPressed: () =>
                                mediaController.loadMoreMediaImages(),
                            icon: const Icon(Iconsax.arrow_down),
                            label: const Text('Load More'),
                          ),
                        )
                      ],
                    ),
                  )
              ],
            );
          }),
        ],
      ),
    );
  }

  List<ImageModel> _getSelectedFolderImages(MediaController controller) {
    List<ImageModel> images = [];
    if (controller.selectedPath.value == MediaCategory.banners) {
      images = controller.allBannerImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.brands) {
      images = controller.allBrandImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.categories) {
      images = controller.allCategoryImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.products) {
      images = controller.allProductImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.users) {
      images = controller.allUserImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    }

    return images;
  }

  Widget _buildEmptyImagesAnimationWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: FSizes.lg * 3),
      child: FAnimationLoaderWidget(
        text: 'Select Your Desired Folder',
        animation: FImages.packageAnimation,
        width: 300,
        height: 300,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  _buildSimpleList(ImageModel image, BuildContext context) {
    return FRoundedImage(
      width: 140,
      height: 140,
      padding: FSizes.sm,
      imageUrl: image.url,
      imageType: ImageType.network,
      margin: FSizes.spaceBtwItems / 2,
      backgroundColor: FHelperFunctions.isDarkMode(context)
          ? FColors.darkerGrey
          : FColors.primaryBackground,
    );
  }

  Widget _buildListWithCheckbox(BuildContext context, ImageModel image) {
    return Stack(
      children: [
        FRoundedImage(
          width: 140,
          height: 140,
          padding: FSizes.sm,
          imageUrl: image.url,
          imageType: ImageType.network,
          margin: FSizes.spaceBtwItems / 2,
          backgroundColor: FHelperFunctions.isDarkMode(context)
              ? FColors.darkerGrey
              : FColors.primaryBackground,
        ),
        Positioned(
          top: FSizes.md,
          right: FSizes.md,
          child: Obx(
            () => Checkbox(
              value: image.isSelected.value,
              onChanged: (selected) {
                if (selected != null) {
                  image.isSelected.value = selected;
                  if (selectedImages.contains(image)) {
                    selectedImages.remove(image);
                  } else {
                    if (!allowMultipleSelection) {
                      for (var otherImage in selectedImages) {
                        if (otherImage != image) {
                          otherImage.isSelected.value = false;
                        }
                      }
                      selectedImages.clear();
                    }
                    selectedImages.add(image);
                  }
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Widget buildAddSelectedImagesButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Close Button
        SizedBox(
          width: 120,
          child: OutlinedButton.icon(
            onPressed: () => Get.back(),
            label: const Text('Close'),
            icon: const Icon(Iconsax.close_circle),
          ),
        ),
        const Gap(FSizes.spaceBtwItems),

        SizedBox(
          width: 120,
          child: ElevatedButton.icon(
            onPressed: () => Get.back(result: selectedImages),
            label: const Text('Add'),
            icon: const Icon(Iconsax.image),
          ),
        )
      ],
    );
  }
}
