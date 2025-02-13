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

class CreateBannerController extends GetxController {
  static CreateBannerController get instance => Get.find();

  final isLoading = false.obs;
  final isActive = false.obs;
  final imageUrl = ''.obs;
  RxString targetScreen = FAppScreens.allAppScreenItems[0].obs;
  final formKey = GlobalKey<FormState>();

  // Pick Thumbnail Image from Media
  Future<void> pickImage() async {
    final mediaController = Get.put(MediaController());
    List<ImageModel>? selectedImages =
        await mediaController.selectImageFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      imageUrl.value = selectedImage.url;
    }
  }

  Future<void> createBanner() async {
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

      final newBanner = BannerModel(
          id: '',
          imageUrl: imageUrl.value,
          targetScreen: targetScreen.value,
          active: isActive.value,
          createdAt: DateTime.now());

      final bannerId =
          await Get.find<BannerRepository>().createBanner(newBanner);
      newBanner.id = bannerId;

      Get.find<BannerController>().addItemToList(newBanner);

      resetFields();

      FFullScreenLoader.stopLoading();
      Snackbars.successSnackbar(
          title: 'Congratulations!',
          message: 'Banner has been created successfully');
    } catch (e) {
      FFullScreenLoader.stopLoading();
      print(e);
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }

  resetFields() {
    imageUrl('');
    isActive(false);
    isLoading(false);
    targetScreen(FAppScreens.allAppScreenItems[0]);
  }
}
