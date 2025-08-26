import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fstoreapp/app.dart';
import 'package:fstoreapp/data/repositories/authentication/authentication_repository.dart';
import 'package:fstoreapp/firebase_options.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  /// Add Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  /// Init Local Storage
  await GetStorage.init();

  // TODO: Init Payment Methods

  // TODO: Await Native Splash
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding
          .ensureInitialized()); // keeps the splash screen on loading the application until we remove it

  /// Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));

  runApp(const MyApp());

  // this
}
 