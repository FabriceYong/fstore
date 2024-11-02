import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fstoreapp/data/repositories/authentication/authentication_repository.dart';
import 'package:fstoreapp/features/personalization/controllers/user_controller/user_controller.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/helpers/network_manager.dart';
import 'package:fstoreapp/utils/loaders/full_screen_loader.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class GoogleSignController extends GetxController {
  static GoogleSignController get instance => Get.find();

  Future<void> googleAuth() async {
    try {
      FFullScreenLoader.openLoadingDialog(
          'Logging in. Please wait...', FImages.docerAnimation);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        Snackbars.errorSnackBar(
            title: 'Ohh Snap!', message: 'No Internet Connection');
        return;
      }
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();
          print('User Email: ${userCredentials!.user!.email}');
      final userController = Get.put(UserController());
      await userController.saveUserDetails(userCredentials);
      FFullScreenLoader.stopLoading();
      Snackbars.successSnackbar(
          title: 'Logged IN', message: 'User logged in successfully');
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FFullScreenLoader.stopLoading();
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      FFullScreenLoader.openLoadingDialog(
          'Logging in. Please wait...', FImages.docerAnimation);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        Snackbars.errorSnackBar(
            title: 'Ohh Snap!', message: 'No Internet Connection');
        return;
      }
      // Trigger the authentication flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      final userController = Get.put(UserController());
      await userController.saveUserDetails(userCredential);
      FFullScreenLoader.stopLoading();
      Snackbars.successSnackbar(
          title: 'Logged In', message: 'User logged in successfully');
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FFullScreenLoader.stopLoading();
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }

  Future<void> facebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        final accessToken = loginResult.accessToken!.tokenString;
        final graphResponse = await FacebookAuth.instance
            .getUserData(fields: 'email, name, picture.url');

        print('User Email ${graphResponse['email']}');
        print('User Name ${graphResponse['name']}');
        print('Profile Picture ${graphResponse['picture.url']}');
      } else {
        print('Login failed: ${loginResult.status}');
      }
    } catch (e) {
      FFullScreenLoader.stopLoading();
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }
}
