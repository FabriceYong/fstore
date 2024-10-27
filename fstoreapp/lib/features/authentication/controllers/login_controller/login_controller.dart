import 'package:flutter/material.dart';
import 'package:fstoreapp/data/repositories/authentication/authentication_repository.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/helpers/network_manager.dart';
import 'package:fstoreapp/utils/loaders/full_screen_loader.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = GetStorage().read('EMAIL') ?? '';
    password.text = GetStorage().read('PASSWORD') ?? '';
    rememberMe.value = GetStorage().read('REMEMBER_ME') ?? false;
    super.onInit();
  }

  Future<void> login() async {
    try {
      FFullScreenLoader.openLoadingDialog(
          'Logging in. Please wait...', FImages.docerAnimation);

      // Check internet connection status
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        Snackbars.errorSnackBar(
            title: 'Ohh Snap!', message: 'No Internet Connection');
        return;
      }

      // Validate form
      if (!loginFormKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }

      // Save Login info to local storage if rememberMe is true
      if (rememberMe.value) {
        GetStorage().writeIfNull('EMAIL', email.text.trim());
        GetStorage().writeIfNull('PASSWORD', password.text.trim());
        GetStorage().writeIfNull('REMEMBER_ME', true);
      } else {
        GetStorage().remove('EMAIL');
        GetStorage().remove('PASSWORD');
        GetStorage().remove('REMEMBER_ME');
      }

      // Perform Login
      await AuthenticationRepository.instance.loginUserWithEmailAndPassword(
          email.text.trim(), password.text.trim());
      FFullScreenLoader.stopLoading();
      Snackbars.successSnackbarGreen(
        title: 'Logged In Successfully',
        message: 'You are logged in successfully. Enjoy...',
      );
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FFullScreenLoader.stopLoading();
      print('Login Error: ${e.toString()}');
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
