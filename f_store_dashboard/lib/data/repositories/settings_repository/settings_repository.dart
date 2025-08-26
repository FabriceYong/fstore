import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_store_dashboard/features/personalization/models/settings_model.dart';
import 'package:f_store_dashboard/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:f_store_dashboard/utils/exceptions/format_exceptions.dart';
import 'package:f_store_dashboard/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SettingsRepository extends GetxController {
  static SettingsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Function to save Setting Data to Firestore
  Future<void> registerSettings(SettingsModel setting) async {
    try {
      await _db.collection('Settings').doc('GLOBAL_SETTINGS').set(setting.toJson());
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatException();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to fetch setting details based on setting ID
  Future<SettingsModel> getSettings() async {
    try{
      final querySnapshot = await _db.collection('Settings').doc('GLOBAL_SETTINGS').get();
      return SettingsModel.fromSnapshot(querySnapshot);
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatException();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to update setting data in Firestore
  Future<void> updateSettingDetails(SettingsModel updateSetting) async {
    try{
      await _db.collection('Settings').doc('GLOBAL_SETTINGS').update(updateSetting.toJson());
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatException();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try{
      await _db.collection('Settings').doc('GLOBAL_SETTINGS').update(json);
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatException();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
