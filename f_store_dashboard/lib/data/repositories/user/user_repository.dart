import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_store_dashboard/data/models/user_model.dart';
import 'package:f_store_dashboard/data/repositories/authentication/authentication_repository.dart';
import 'package:f_store_dashboard/features/shop/models/order_model/order_model.dart';
import 'package:f_store_dashboard/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:f_store_dashboard/utils/exceptions/firebase_exceptions.dart';
import 'package:f_store_dashboard/utils/exceptions/format_exceptions.dart';
import 'package:f_store_dashboard/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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

  /// [FetchUserDetails] -- FETCH USER DETAILS
  Future<UserModel> fetchUserDetails(String userId) async {
    try {
      final documentSnapshot = await _db.collection('Users').doc(userId).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
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

  /// [Fetch All Users] FETCH ALL USERS IN THE DATABASE
  Future<List<UserModel>> fetchAllUsers() async {
    try{
      final querySnapshot = await _db.collection('Users').orderBy('FirstName').get();
      return querySnapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
    }on FirebaseAuthException catch (e) {
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

  /// [Fetch User Orders] - FETCH ORDERS FOR A SINGLE USER
  Future<List<OrderModel>> fetchUserOrders(String userId) async {
    try{
      final documentSnapshot = await _db.collection('Orders').where('UserId', isEqualTo: userId).get();
      return documentSnapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
    }on FirebaseAuthException catch(e){
      throw FFirebaseAuthException(e.code).message;
    }on FirebaseException catch(e){
      throw FFirebaseException(e.code).message;
    }on FormatException catch(_){
      throw const FFormatException();
    }on PlatformException catch(e){
      throw FPlatformException(e.code).message;
    }catch(e){
      print(e);
      if(kDebugMode) print('Something went wrong $e');
      throw 'Something went wrong. Please try again. $e';
    }
  }

  /// [Update User Data in Firestore] UPDATE FIRESTORE USER DATA
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .update(json);
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

  Future<void> updateUserProfile(UserModel user) async {
    try{
      await _db.collection('Users').doc(user.id).update(user.toJson());
    }on FirebaseAuthException catch (e) {
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

  /// [Delete User] - DELETE USER METHOD
  Future<void> deleteUser(String userId) async {
    try{
      await _db.collection('Users').doc(userId).delete();
    }on FirebaseException catch(e){
      throw e.message!;
    }on PlatformException catch(e){
      throw e.message!;
    }catch(e){
      print(e);
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Upload Any Image]  -- UPLOAD ANY IMAGE
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      SettableMetadata? metadata;
      // Add Metadata for web (optional but good practice)
      if(kIsWeb){
        metadata = SettableMetadata(contentType: image.mimeType ?? 'image/jpeg');
      }

      TaskSnapshot uploadTaskSnapshot;
      
      if(kIsWeb){
        // Web implementation: User putData with bytes
        uploadTaskSnapshot = await ref.putData(await image.readAsBytes(), metadata);
      }else {
        // Mobile implementation: Use putFile
        uploadTaskSnapshot = await ref.putFile(File(image.path)); // Use File constructor
      }

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
