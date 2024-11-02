import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fstoreapp/data/repositories/user/user_repository.dart';
import 'package:fstoreapp/features/authentication/screens/login/login.dart';
import 'package:fstoreapp/features/authentication/screens/onboarding/onboarding.dart';
import 'package:fstoreapp/features/authentication/screens/register/widgets/verify_email.dart';
import 'package:fstoreapp/navigation_menu.dart';
import 'package:fstoreapp/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:fstoreapp/utils/exceptions/firebase_exceptions.dart';
import 'package:fstoreapp/utils/exceptions/format_exceptions.dart';
import 'package:fstoreapp/utils/exceptions/platform_exceptions.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final storage = GetStorage();
  final _auth = FirebaseAuth.instance;
  User? get authUser => _auth.currentUser;

  /// Called form main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
    super.onReady();
  }

  /// Function to show Relevant screen
  void screenRedirect() {
    final User? user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser!.email));
      }
    } else {
      storage.writeIfNull('isFirstTime', true);
      storage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(
              () => const OnboardingScreen(),
            );
    }
  }

  /** ------------------------------- Email & Password Sign-In -------------------------------------- */

  /// [EmailAuthentication] -- SignIn
  Future<UserCredential> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      return _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailAuthentication] -- REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailVerification] -- EMAIL VERIFICATION\
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [PasswordReset] -- Password Reset
  Future<void> sendPasswordResetEmail(String email) {
    try {
      return _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Re-Authentication] -- ReAuthenticate User
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      final AuthCredential authCredential =
          EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// ============================= Federated identity & social sign-in ========================
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went wrong: $e');
      return null;
    }
  }

  /// [LOGOUT] -- Logout User
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      Snackbars.successSnackbar(
          title: 'Logged Out!', message: 'You are now logged out of the app');
      screenRedirect();
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [DELETE ACCOUNT] -- Delete User Account
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(authUser!.uid);
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
