import 'dart:typed_data';

import 'package:f_store_dashboard/data/repositories/media_repository/media_repository.dart';
import 'package:f_store_dashboard/features/media/models/image_model.dart';
import 'package:f_store_dashboard/features/media/screens/widgets/media_content.dart';
import 'package:f_store_dashboard/features/media/screens/widgets/media_uploader.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/constants/text_strings.dart';
import 'package:f_store_dashboard/utils/dialogs/dialog.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/loaders/circular_loader.dart';
import 'package:f_store_dashboard/utils/loaders/full_screen_loader.dart';
import 'package:f_store_dashboard/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  final RxBool loading = false.obs;

  // Updated constants
  final int initialLoadCount = 35;
  final int loadMoreCount = 30;

  // Track if more images are available per category
  final RxMap<MediaCategory, bool> hasMoreImages = <MediaCategory, bool>{}.obs;

  late DropzoneViewController dropzoneController;
  final RxBool showImagesUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;

  final RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannerImages = <ImageModel>[].obs;
  final RxList<ImageModel> allProductImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandImages = <ImageModel>[].obs;
  final RxList<ImageModel> allUserImages = <ImageModel>[].obs;

  final MediaRepository mediaRepository = MediaRepository();

  // Helper to get the correct list based on selectedPath
  RxList<ImageModel> _getTargetList() {
    switch (selectedPath.value) {
      case MediaCategory.banners:
        return allBannerImages;
      case MediaCategory.brands:
        return allBrandImages;
      case MediaCategory.categories:
        return allCategoryImages;
      case MediaCategory.products:
        return allProductImages;
      case MediaCategory.users:
        return allUserImages;
      default:
        // Should not happen if a category is selected, but return an empty list as fallback
        return <ImageModel>[].obs;
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize hasMoreImages for all categories
    for (var category in MediaCategory.values) {
      if (category != MediaCategory.folders) { // Exclude 'folders' pseudo-category
        hasMoreImages[category] = true;
      }
    }
  }


  void getMediaImages() async {
    // Don't fetch if the category is 'folders'
    if (selectedPath.value == MediaCategory.folders) return;

    final RxList<ImageModel> targetList = _getTargetList();

    // Only fetch if the list is currently empty (initial load for this category)
    if (targetList.isNotEmpty) {
       // If list is not empty, assume it's already loaded, reset loading state if needed
       if (loading.value) loading.value = false;
       return;
    }


    try {
      loading.value = true;
      hasMoreImages[selectedPath.value] = true; // Assume more images initially

      final images = await mediaRepository.fetchImagesFromDatabase(
          selectedPath.value, initialLoadCount);

      // Use assignAll for the initial fetch
      targetList.assignAll(images);

      // Update hasMoreImages based on the fetched count
      if (images.length < initialLoadCount) {
        hasMoreImages[selectedPath.value] = false;
      }

      loading.value = false;
    } catch (e) {
      loading.value = false;
      // Reset hasMore on error? Or leave as true to allow retry? Leaving as true for now.
      // hasMoreImages[selectedPath.value] = false;
      Snackbars.errorSnackBar(
          title: 'Ohh Snap!',
          message:
              'Unable to load initial images, something went wrong. Please try again');
    }
  }

  void loadMoreMediaImages() async {
     // Don't load more if the category is 'folders' or if we know there are no more images
    if (selectedPath.value == MediaCategory.folders || !(hasMoreImages[selectedPath.value] ?? false)) {
      return;
    }

    final RxList<ImageModel> targetList = _getTargetList();

    // Ensure list isn't empty before trying to load more
    if (targetList.isEmpty) {
      // Maybe call getMediaImages instead? Or just return? Returning for now.
      return;
    }


    try {
      loading.value = true;

      // Get the timestamp of the last image currently loaded
      final DateTime? lastTimestamp = targetList.last.createdAt;
      if (lastTimestamp == null) {
         // Handle case where last image has no timestamp (shouldn't happen ideally)
         loading.value = false;
         Snackbars.errorSnackBar(title: 'Error', message: 'Cannot determine pagination point.');
         return;
      }


      final images = await mediaRepository.loadMoreImagesFromDatabase(
          selectedPath.value,
          loadMoreCount, // Use loadMoreCount here
          lastTimestamp); // Pass the correct timestamp

      // Use addAll to append new images
      targetList.addAll(images);

      // Update hasMoreImages based on the fetched count
      if (images.length < loadMoreCount) {
        hasMoreImages[selectedPath.value] = false;
      }

      loading.value = false;
    } catch (e) { // Add the missing catch block
      loading.value = false;
      Snackbars.errorSnackBar(
          title: 'Ohh Snap!',
          message:
              'Unable to load more images, something went wrong. Please try again');
    }
  } // Add the missing closing brace for loadMoreMediaImages

  // --- Restore Missing Methods ---

  Future<void> selectedLocalImages() async {
    final files = await dropzoneController
        .pickFiles(multiple: true, mime: ['image/jpeg', 'image/png']);
    if (files.isNotEmpty) {
      for (var file in files) {
        final bytes = await dropzoneController.getFileData(file);
        final image = ImageModel(
          url: '',
          file: file,
          folder: '',
          filename: file.name,
          localImageToDisplay: Uint8List.fromList(bytes),
        );

        selectedImagesToUpload.add(image);
      }
    }
  }

  void uploadImagesConfirmationBox() {
    if (selectedPath.value == MediaCategory.folders) {
      Snackbars.warningSnackBar(
          title: 'Select Folder',
          message: 'Please select a folder in order to upload the image(s)');
      return;
    }

    FDialogs.defaultDialog(
      context: Get.context!,
      title: 'Upload Images',
      content:
          'Are you sure you want to upload the selected image(s) in the ${selectedPath.value.name.toUpperCase()} folder?',
      positive: 'Upload',
      negative: 'Cancel',
      onPositive: () async => await uploadImages(),
    );
  }

  Future<void> uploadImages() async {
    try {
      // Remove confirmation box
      Get.back();

      // Start Loader
      uploadImagesLoader();

      // Get the Selected Category
      MediaCategory selectedCategory = selectedPath.value;

      // Get the corresponding list to update
      RxList<ImageModel> targetList;

      // Check the selected category and update the corresponding list
      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;
        default:
          targetList = allImages;
          break;
      }

      // Upload and add images to the target list
      // Using a reverse loop to avoid "Concurrent Modification during iteration" Error
      for (int i = selectedImagesToUpload.length - 1; i >= 0; i--) {
        var selectedImage = selectedImagesToUpload[i];
        final image = selectedImage.file!;

        /// Upload Image to the database
        final ImageModel uploadedImage =
            await mediaRepository.uploadImageFileInStorage(
                dropzoneController: dropzoneController,
                file: image,
                path: getSelectedPath(),
                imageName: selectedImage.filename);

        // Upload Image to Firestore
        uploadedImage.mediaCategory = selectedCategory.name;
        final id =
            await mediaRepository.uploadImageFileInDatabase(uploadedImage);

        uploadedImage.id = id;

        selectedImagesToUpload.removeAt(i);
        // selectedImagesToUpload
        //     .removeWhere((x) => selectedImagesToUpload[i] == x);

        targetList.add(uploadedImage);
      }

      FFullScreenLoader.stopLoading();
      Snackbars.successSnackbar(
          title: 'Files Uploaded',
          message: 'Your image(s) have been successfully uploaded');
    } catch (e) {
      print(e);
      FFullScreenLoader.stopLoading();
      Snackbars.errorSnackBar(
          title: 'Error Uploading Image!',
          message:
              'Something went wrong while uploading the image(s). Please try again');
    }
  }

  void uploadImagesLoader() {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              title: const Text('Uploading Image(s)'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    FImages.cloudUploadingAnimation,
                    width: 300,
                    height: 300,
                  ),
                  const Gap(FSizes.spaceBtwItems),
                  const Text('Sit tight, your image(s) are uploading'),
                ],
              ),
            ),
          );
        });
  }

  String getSelectedPath() {
    String path = '';
    switch (selectedPath.value) {
      case MediaCategory.banners:
        path = FTexts.bannerStoragePath;
        break;
      case MediaCategory.products:
        path = FTexts.productImageStoragePath;
        break;
      case MediaCategory.categories:
        path = FTexts.categoryStoragePath;
        break;
      case MediaCategory.brands:
        path = FTexts.brandsStoragePath;
        break;
      case MediaCategory.users:
        path = FTexts.usersStoragePath;
        break;
      default:
        path = 'Others';
    }
    return path;
  }

  /// Remove Image popup
  void removeCloudImageConfirmation(ImageModel image) {
    FDialogs.defaultDialog(
        context: Get.context!,
        content: 'Are you sure you want to delete this message?',
        onPositive: () {
          // Remove Already displayed image popup
          Get.back();
          removeCloudImage(image);
        });
  }

  void removeCloudImage(ImageModel image) async {
    try {
      Get.back();

      Get.defaultDialog(
        title: '',
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const PopScope(
          canPop: false,
          child: SizedBox(
            width: 150,
            height: 150,
            child: FCircularLoader(),
          ),
        ),
      );

      await mediaRepository.deleteImageFromDatabase(image);

      // Get the corresponding list to update
      RxList<ImageModel> targetList;

      // Check the selected category and update the corresponding list
      switch (selectedPath.value) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;
        default:
          targetList = allImages;
          break;
      }

      targetList.remove(image);
      update();

      FFullScreenLoader.stopLoading();
      Snackbars.successSnackbar(
          title: 'Image Deleted',
          message: 'The image has been successfully deleted from the database');
    } catch (e) {
      print(e);
      FFullScreenLoader.stopLoading();
    }
  }

  /// Image selection Bottom sheet
  Future<List<ImageModel>?> selectImageFromMedia(
      {List<String>? selectedUrls,
      bool allowSelection = true,
      bool multipleSelection = false}) async {
    showImagesUploaderSection.value = true;

    List<ImageModel>? selectedImages = await Get.bottomSheet<List<ImageModel>>(
        isScrollControlled: true,
        backgroundColor: FHelperFunctions.isDarkMode(Get.context!)
            ? Colors.black
            : FColors.primaryBackground,
        FractionallySizedBox(
          heightFactor: 1,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(FSizes.defaultSpace),
              child: Column(
                children: [
                  const FMediaUploaderWidget(),
                  const SizedBox(height: FSizes.spaceBtwItems),
                  FMediaContentWidget(
                    allowSelection: allowSelection,
                    alreadySelectedUrls: selectedUrls ?? [],
                    allowMultipleSelection: multipleSelection,
                  )
                ],
              ),
            ),
          ),
        ));
    return selectedImages;
  }
} // Add the missing closing brace for the class
