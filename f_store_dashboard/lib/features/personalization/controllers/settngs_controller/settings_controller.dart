import 'package:f_store_dashboard/data/repositories/settings_repository/settings_repository.dart';
import 'package:f_store_dashboard/features/media/controllers/media_controller.dart';
import 'package:f_store_dashboard/features/media/models/image_model.dart';
import 'package:f_store_dashboard/features/personalization/models/settings_model.dart';
import 'package:f_store_dashboard/utils/helpers/network_manager.dart';
import 'package:f_store_dashboard/utils/loaders/full_screen_loader.dart';
import 'package:f_store_dashboard/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  final loading = false.obs;
  Rx<SettingsModel> settings = SettingsModel().obs;

  final formKey = GlobalKey<FormState>();
  final appNameController = TextEditingController();
  final taxController = TextEditingController();
  final shippingController = TextEditingController();
  final freeShippingThresholdController = TextEditingController();

  // Dependencies
  final _settingsRepository = Get.put(SettingsRepository());

  @override
  void onInit() {
    // fetch settings details on controller initialization
    fetchSettingsDetails();
    super.onInit();
  }

  Future<SettingsModel> fetchSettingsDetails() async {
    try {
      loading(true);
      final settings = await _settingsRepository.getSettings();
      this.settings.value = settings;

      appNameController.text = settings.appName;
      taxController.text = settings.taxRate.toString();
      shippingController.text = settings.shippingCost.toString();
      freeShippingThresholdController.text =
          settings.freeShippingThreshold == null
              ? ''
              : settings.freeShippingThreshold.toString();

      loading(false);

      return settings;
    } catch (e) {
      print(e);
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
      return SettingsModel();
    } finally {
      loading(false);
    }
  }

  /// Pick thumbnail Image from Media
  void updateAppLogo() async {
    try {
      loading(true);
      final mediaController = Get.put(MediaController());
      List<ImageModel>? selectedImages =
          await mediaController.selectImageFromMedia();

      if (selectedImages != null && selectedImages.isNotEmpty) {
        // Set the selected image to the main image or perform any other action
        ImageModel selectedImage = selectedImages.first;

        // Update settings in Firestore
        await _settingsRepository
            .updateSingleField({'appLogo': selectedImage.url});

        // Update the main image using the url
        settings.value.appLogo = selectedImage.url;
        settings.refresh();

        Snackbars.successSnackbar(
            title: 'Congratulations!',
            message: 'The new app logo has been set');
      }

      loading(false);
    } catch (e) {
      print(e);
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    } finally {
      loading(false);
    }
  }

  void updateSettingsInformation() async {
    try{
      loading(true);

      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        FFullScreenLoader.stopLoading();
        Snackbars.errorSnackBar(title: 'Opps!', message: 'No Internet Connection');
        return;
      }

      // Validate form Fields
      if(!formKey.currentState!.validate()){
        FFullScreenLoader.stopLoading();
        return;
      }

      settings.value.appName = appNameController.text.trim();
      settings.value.taxRate = double.tryParse(taxController.text.trim()) ?? 0.0;
      settings.value.shippingCost = double.tryParse(shippingController.text.trim()) ?? 0.0;
      settings.value.freeShippingThreshold = double.tryParse(freeShippingThresholdController.text.trim()) ?? 0.0;

      await _settingsRepository.updateSettingDetails(settings.value);
      settings.refresh();

      Snackbars.successSnackbar(title: 'Congratulations!', message: 'Your app settings have been updated');
    }catch(e){
      print(e);
      Snackbars.errorSnackBar(title: 'Opps!', message:e.toString());
    }finally{
      loading(false);
    }
  }
}
