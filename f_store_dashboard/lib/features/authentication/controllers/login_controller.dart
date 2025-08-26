import 'package:f_store_dashboard/data/models/user_model.dart';
import 'package:f_store_dashboard/data/repositories/authentication/authentication_repository.dart';
import 'package:f_store_dashboard/data/repositories/settings_repository/settings_repository.dart';
import 'package:f_store_dashboard/data/repositories/user/user_repository.dart';
import 'package:f_store_dashboard/features/authentication/controllers/user_controller.dart';
import 'package:f_store_dashboard/features/personalization/models/settings_model.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/helpers/network_manager.dart';
import 'package:f_store_dashboard/utils/loaders/full_screen_loader.dart';
import 'package:f_store_dashboard/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// Controller for handling login functionality
class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  //Variables
  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// Handles email and password sign_in process
  Future<void> login() async {
    try {
      // Start Loading
      FFullScreenLoader.openLoadingDialog(
          'Logging you in...', FImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Snackbars.errorSnackBar(
            title: 'Ohh Snap!', message: 'No Internet Connection');
        FFullScreenLoader.stopLoading();
        return;
      }

      // FormValidation
      if (!loginFormKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user with Email and Password Authentication
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Fetch user details and assign to UserController
      final user = await UserController.instance.fetchUserDetails();

      // if user is not admin, logout and return
      if (user.role != AppRole.admin) {
        await AuthenticationRepository.instance.logout();
        Snackbars.errorSnackBar(
            title: 'Not Authorized',
            message:
                'You are not authorized or do not have access to this site, Please contact the site administrator');
      } else {
        // Redirect
        AuthenticationRepository.instance.screenRedirect();
      }

      print(user.role);

      // Remove Loader
      FFullScreenLoader.stopLoading();
      //Redirect to the respective screen
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FFullScreenLoader.stopLoading();
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }

  /// Handles registration of admin user
  Future<void> registerAdmin() async {
    try {
      // Start Loading
      FFullScreenLoader.openLoadingDialog(
          'Registering Admin...', FImages.docerAnimation);
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        return;
      }

      // Register user using Email & password Authentication
      // await AuthenticationRepository.instance.registerUserWithEmailAndPassword(email.text, password.text);
      await AuthenticationRepository.instance.registerUserWithEmailAndPassword(
          'jamesbond@gmail.com', 'James@1234');

      // Create admin record in the Firestore
      final UserRepository userRepository = Get.put(UserRepository());

      await userRepository.createUser(
        UserModel(
          id: AuthenticationRepository.instance.authUser!.uid,
          firstName: 'James',
          lastName: 'Bond',
          userName: 'cwf_fabrice',
          email: 'jamesbond@gmail.com',
          role: AppRole.admin,
          createdAt: DateTime.now(),
          profilePicture: '',
          phoneNumber: '01234569789',
        ),
      );

      // Create settings record in the Firestore
      final settingsRepository = Get.put(SettingsRepository());
      await settingsRepository.registerSettings(SettingsModel(appLogo: '', appName: 'My App', taxRate: 0.0, shippingCost: 0.0));

      // Stop Loader
      FFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FFullScreenLoader.stopLoading();
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }
}
