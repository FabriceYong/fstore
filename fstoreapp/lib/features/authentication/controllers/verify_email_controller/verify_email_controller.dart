import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fstoreapp/common/widgets/success_screen/success_screen.dart';
import 'package:fstoreapp/data/repositories/authentication/authentication_repository.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/text_strings.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get insance => Get.find();

  /// Send Email Whenever Verify screen appears & set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// Send Email Verification
  void sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      Snackbars.successSnackbar(
          title: 'Verification Email Sent',
          message:
              'Verification email sent, please check your inbox and click on the link to verify your email');
    } catch (e) {
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }

  ///  Timer to automatically redirect on Email Verification
  void setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      await FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        timer.cancel();
        Get.off(
          () => SuccessScreen(
            image: FImages.successfullyRegisteredAnimation,
            title: FTexts.yourAccountCreatedTitle,
            subTitle: FTexts.yourAccountCreatedSubTitle,
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        );
      }
    });
  }

  /// Manually Check if Email Verified
  void checkEmailVerificationStatus() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      Get.off(
        () => SuccessScreen(
          image: FImages.successfullyRegisteredAnimation,
          title: FTexts.yourAccountCreatedTitle,
          subTitle: FTexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    }
  }
}
