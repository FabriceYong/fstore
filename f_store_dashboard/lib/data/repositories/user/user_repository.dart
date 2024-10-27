import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_store_dashboard/data/repositories/authentication/authentication_repository.dart';
import 'package:f_store_dashboard/data/repositories/authentication/models/user_model.dart';
import 'package:f_store_dashboard/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:f_store_dashboard/utils/exceptions/firebase_exceptions.dart';
import 'package:f_store_dashboard/utils/exceptions/format_exceptions.dart';
import 'package:f_store_dashboard/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// [Create User Data in Firestore] CREATE FIRESTORE USER DATA
  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw FFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatException();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[FetchAdminDetails] -- FETCH ADMIN DETAILS
  Future<UserModel> fetchAdminDetails() async {
    try {
      final docSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .get();

      return UserModel.fromSnapshot(docSnapshot);
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw FFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatException();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Update User Data in Firestore] UPDATE FIRESTORE USER DATA
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try{
       await _db.collection('Users').doc(AuthenticationRepository.instance.authUser!.uid).update(json);
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw FFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatException();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Upload Any Image]  -- UPLOAD ANY IMAGE
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      final uploadTaskSnapshot = await ref.putFile(File(image.path));
      final downloadUrl = await uploadTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      if (e is FirebaseException) {
        throw 'Firebase Exception: ${e.message}';
      } else if (e is SocketException) {
        throw 'Network Error: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Platform Exception: ${e.message}';
      } else {
        throw 'Something went wrong. Please try again';
      }
    }
  }
}
