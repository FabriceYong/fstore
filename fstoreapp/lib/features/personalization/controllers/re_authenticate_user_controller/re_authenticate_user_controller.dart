import 'package:flutter/material.dart';
import 'package:fstoreapp/data/repositories/authentication/authentication_repository.dart';
import 'package:fstoreapp/features/authentication/screens/login/login.dart';
import 'package:fstoreapp/features/personalization/screens/profile/widgets/re_authenticate_user_login.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/network_manager.dart';
import 'package:fstoreapp/utils/loaders/full_screen_loader.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ReAuthenticateUserController extends GetxController {
  static ReAuthenticateUserController get instance => Get.find();

  final hidePassword = true.obs;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final reAuthenticateUserFormKey = GlobalKey<FormState>();

  /// Delete User Account
  Future<void> deleteUserAccount() async {
    try {
      FFullScreenLoader.openLoadingDialog(
          'Processing your request. Please wait...', FImages.docerAnimation);

      /// First Re-Authenticate User
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re-Verify Auth Email
        if (provider == 'google.com') {
          // await auth.signInWithGoogle();
          // await auth.deleteAccount();
          FFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          FFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthenticateUserLogin());
        }
      }
    } catch (e) {
      FFullScreenLoader.stopLoading();
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }

  /// Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(FSizes.spaceBtwItems),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account permanently?, This acton irreversible and all of your data will be removed permanently',
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        onPressed: () async => deleteUserAccount(),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: FSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.context!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  /// -- Re-Authenticate before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      FFullScreenLoader.openLoadingDialog(
          'Proccessing, Please wait...', FImages.docerAnimation);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        Snackbars.errorSnackBar(
            title: 'Ohh Snap!', message: 'No Internet Connection');
        return;
      }
      if (!reAuthenticateUserFormKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              email.text.trim(), password.text.trim());
      await AuthenticationRepository.instance.deleteAccount();

      final storage = GetStorage();
      if (storage.hasData('EMAIL') ||
          storage.hasData('PASSWORD') ||
          storage.hasData('REMEMBER_ME')) {
        storage.remove('EMAIL');
        storage.remove('PASSWORD');
        storage.remove('REMEMBER_ME');
      }

      FFullScreenLoader.stopLoading();
      Snackbars.successSnackbar(
          title: 'Account Deleted',
          message: 'Your account has been deleted successfully');
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      FFullScreenLoader.stopLoading();
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }
}
