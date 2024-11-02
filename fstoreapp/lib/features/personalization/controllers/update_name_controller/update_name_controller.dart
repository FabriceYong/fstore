import 'package:flutter/material.dart';
import 'package:fstoreapp/data/repositories/user/user_repository.dart';
import 'package:fstoreapp/features/personalization/controllers/user_controller/user_controller.dart';
import 'package:fstoreapp/features/personalization/screens/profile/profile.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/helpers/network_manager.dart';
import 'package:fstoreapp/utils/loaders/full_screen_loader.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final userController = Get.put(UserController());

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final updateNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  void initializeNames() {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateName() async {
    try {
      FFullScreenLoader.openLoadingDialog(
          'Processing your request. Please wait...', FImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        Snackbars.errorSnackBar(
            title: 'Ohh Snap!', message: 'No Internet Connection');
        return;
      }

      if (!updateNameFormKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> user = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };

      await UserRepository.instance.updateSingleField(user);

      /// Update the Rx Values
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      FFullScreenLoader.stopLoading();
      Snackbars.successSnackbar(
          title: 'Name Updated',
          message: 'Congratulations!, Your name has been updated successfully');
      Get.offAll(() => const ProfileScreen());
    } catch (e) {
      FFullScreenLoader.stopLoading();
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }
}
