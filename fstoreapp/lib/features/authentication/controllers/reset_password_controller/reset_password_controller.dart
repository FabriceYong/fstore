import 'package:flutter/material.dart';
import 'package:fstoreapp/data/repositories/authentication/authentication_repository.dart';
import 'package:fstoreapp/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/helpers/network_manager.dart';
import 'package:fstoreapp/utils/loaders/full_screen_loader.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  static ResetPasswordController get instance => Get.find();

  final TextEditingController email = TextEditingController();
  final resetPasswordFormKey = GlobalKey<FormState>();

  void resetPassword() async {
    try {
      FFullScreenLoader.openLoadingDialog(
          'Processing your request. Please wait...', FImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        Snackbars.errorSnackBar(
            title: 'Ohh Snap', message: 'No Internet Connection');
        return;
      }

      if (!resetPasswordFormKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      FFullScreenLoader.stopLoading();
      Snackbars.successSnackbar(
          title: 'Email Sent!',
          message:
              'Reset Password sent, check your inbox and click on the link to reset your password'
                  .tr);
      Get.offAll(() => ResetPasswordScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      FFullScreenLoader.stopLoading();
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }

  void resendResetPasswordEmail(String email) async {
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

      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      FFullScreenLoader.stopLoading();
      Snackbars.successSnackbar(
        title: 'Email Sent!',
        message:
            'Reset Password sent, check your inbox and click on the link to reset your password'
                .tr,
      );
      Get.back();
    } catch (e) {
      FFullScreenLoader.stopLoading();
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
