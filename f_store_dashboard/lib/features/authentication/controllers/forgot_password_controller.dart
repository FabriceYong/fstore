import 'package:f_store_dashboard/data/repositories/authentication/authentication_repository.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/helpers/network_manager.dart';
import 'package:f_store_dashboard/utils/loaders/full_screen_loader.dart';
import 'package:f_store_dashboard/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Reset Password Controller
class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  final TextEditingController email = TextEditingController();
  final forgotPasswordKey = GlobalKey<FormState>();

  ///[SendPasswordResetEmail] -- SEND PASSWORD RESET EMAIL
  Future<void> sendPasswordResetEmail() async {
    try {
      // Start Loader
      FFullScreenLoader.openLoadingDialog(
          'Processing request. Please wait...', FImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        return;
      }

      // Validate Email
      if (!forgotPasswordKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }

      // Send Email to Reset Password
      await AuthenticationRepository.instance
          .sendForgotPasswordEmail(email.text.trim());

      // Remove Loader
      FFullScreenLoader.stopLoading();
      // Show Success Screen
      Snackbars.successSnackbar(
          title: 'Email Sent',
          message:
              'Password reset email sent, check your inbox and click on the link to reset your password');

      // Redirect
      Get.offAllNamed(FRoutes.resetPassword,
          parameters: {'email': email.text.trim()});
    } catch (e) {
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
      FFullScreenLoader.stopLoading();
    }
  }

  ///[ResendPasswordResetEmail] -- RESEND PASSWORD RESET EMAIL
  Future<void> resendPasswordResetEmail({required String email}) async {
    try {
      // Start Loader
      FFullScreenLoader.openLoadingDialog(
          'Processing request. Please wait...', FImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        return;
      }

      // Send Email to Reset Password
      await AuthenticationRepository.instance
          .sendForgotPasswordEmail(email.trim());

      // Remove Loader
      FFullScreenLoader.stopLoading();
      // Show Success Screen
      Snackbars.successSnackbar(
          title: 'Email Sent',
          message:
              'Password reset email sent, check your inbox and click on the link to reset your password');

      // Redirect
      Get.offAllNamed(FRoutes.resetPassword);
    } catch (e) {
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
      FFullScreenLoader.stopLoading();
    }
  }
}
