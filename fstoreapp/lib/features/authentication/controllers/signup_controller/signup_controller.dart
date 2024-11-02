import 'package:flutter/material.dart';
import 'package:fstoreapp/data/models/user_model/user_model.dart';
import 'package:fstoreapp/data/repositories/authentication/authentication_repository.dart';
import 'package:fstoreapp/data/repositories/user/user_repository.dart';
import 'package:fstoreapp/features/authentication/screens/register/widgets/verify_email.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/helpers/network_manager.dart';
import 'package:fstoreapp/utils/loaders/full_screen_loader.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final privacyPolicy = false.obs;
  final hidePassword = true.obs;
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();

  final signupFormKey = GlobalKey<FormState>();

  /// -- SIGNUP
  Future<void> signup() async {
    try {
      FFullScreenLoader.openLoadingDialog(
          'We are processing your information...', FImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        Snackbars.errorSnackBar(
            title: 'Ohh Snap!', message: 'No Internet Connection');
        return;
      }

      if (!signupFormKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }

      if (!privacyPolicy.value) {
        Snackbars.warningSnackBar(
            title: 'Ohh Snap!',
            message:
                'In order to create account, you must read the Privacy Policy & Terms of use');
        FFullScreenLoader.stopLoading();
        return;
      }

      final user = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      final newUser = UserModel(
          email: email.text.trim(),
          id: user.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          userName: username.text.trim(),
          profilePicture: '',
          phoneNumber: phoneNumber.text.trim());

      final UserRepository userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      FFullScreenLoader.stopLoading();

      Snackbars.successSnackbar(
          title: 'Congratulations',
          message: 'Your account has been created! Verify email to continue.');
      Get.to(() => VerifyEmailScreen(
            email: newUser.email,
          ));
    } catch (e) {
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
      FFullScreenLoader.stopLoading();
    }
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    username.dispose();
    email.dispose();
    phoneNumber.dispose();
    password.dispose();
    super.dispose();
  }
}
