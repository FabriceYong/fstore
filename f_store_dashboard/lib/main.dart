import 'package:f_store_dashboard/app.dart';
import 'package:f_store_dashboard/data/repositories/authentication/authentication_repository.dart';
import 'package:f_store_dashboard/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  //Ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize Get Local Storage
  await GetStorage.init();

  // Remove hash(#) sign from url
  setPathUrlStrategy();

  // Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((_) => Get.put(AuthenticationRepository()));

  // Main App Starts here...
  runApp(const App());
}
