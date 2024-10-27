import 'package:flutter/material.dart';
import 'package:fstoreapp/features/personalization/controllers/user_controller/user_controller.dart';
import 'package:fstoreapp/features/personalization/screens/profile/profile.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/helpers/network_manager.dart';
import 'package:fstoreapp/utils/loaders/full_screen_loader.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/user/user_repository.dart';

class UpdateUsernameController extends GetxController {
  static UpdateUsernameController get instance => Get.find();

  final userController = Get.put(UserController());
  final TextEditingController userName = TextEditingController();
  final updateUsernameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    userName.text = userController.user.value.userName;
    super.onInit();
  }

  void updateUsername() async {
    try {
      FFullScreenLoader.openLoadingDialog(
          'Updating UserName. Please wait', FImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        Snackbars.errorSnackBar(
            title: 'Ohh Snap!', message: 'No Internet Connection');
        return;
      }
      if (!updateUsernameFormKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }
      Map<String, dynamic> username = {'UserName': userName.text.trim()};
      await UserRepository.instance.updateSingleField(username);
      userController.user.value.userName = userName.text.trim();
      FFullScreenLoader.stopLoading();
      Snackbars.successSnackbar(
          title: 'User Name Update',
          message: 'Congratulations!, Your User Name has been updated');
      Get.offAll(() => const ProfileScreen());
    } catch (e) {
      FFullScreenLoader.stopLoading();
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }
}
