import 'package:f_store_dashboard/data/repositories/banner_repository/banner_repository.dart';
import 'package:f_store_dashboard/features/media/controllers/media_controller.dart';
import 'package:f_store_dashboard/features/media/models/image_model.dart';
import 'package:f_store_dashboard/features/shop/controllers/banners_controller/banner_controller.dart';
import 'package:f_store_dashboard/features/shop/models/banner_model/banner_model.dart';
import 'package:f_store_dashboard/routes/app_screens.dart';
import 'package:f_store_dashboard/utils/helpers/network_manager.dart';
import 'package:f_store_dashboard/utils/loaders/full_screen_loader.dart';
import 'package:f_store_dashboard/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateBannerController extends GetxController {
  static UpdateBannerController get instance => Get.find();

  final isLoading = false.obs;
  final imageUrl = ''.obs;
  final isActive = false.obs;
  final targetScreen = FAppScreens.allAppScreenItems[0].obs;
  final formKey = GlobalKey<FormState>();

  // Init Data
  void init(BannerModel banner) {
    imageUrl.value = banner.imageUrl;
    isActive.value = banner.active;
    targetScreen.value = banner.targetScreen;
  }

  resetFields() {
    imageUrl('');
    isActive(false);
    isLoading(false);
    targetScreen(FAppScreens.allAppScreenItems[0]);
  }

  Future<void> pickImage() async {
    final mediaController = Get.put(MediaController());
    final List<ImageModel>? selectedImages =
        await mediaController.selectImageFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      imageUrl.value = selectedImage.url;
    }
  }

  Future<void> updateBanner(BannerModel banner) async {
    try {
      FFullScreenLoader.popUpCircular();

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        Snackbars.errorSnackBar(
            title: 'Ohh Snap!', message: 'No Internet Connection');
        return;
      }

      if (!formKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }

      if (banner.imageUrl != imageUrl.value ||
          banner.active != isActive.value ||
          banner.targetScreen != targetScreen.value) {
        banner.imageUrl = imageUrl.value;
        banner.active = isActive.value;
        banner.targetScreen = targetScreen.value;
        banner.updatedAt = DateTime.now();

        // Update Banner
        await Get.find<BannerRepository>().updateBanner(banner);
      }

      Get.find<BannerController>().updateItemInList(banner);

      resetFields();
      FFullScreenLoader.stopLoading();
      Snackbars.successSnackbar(
          title: 'Congratulations!',
          message: 'Banner has been successfully updated');
    } catch (e) {
      FFullScreenLoader.stopLoading();
      print(e);
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }
}
