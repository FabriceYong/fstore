import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_store_dashboard/features/shop/models/banner_model/banner_model.dart';
import 'package:f_store_dashboard/utils/exceptions/firebase_exceptions.dart';
import 'package:f_store_dashboard/utils/exceptions/format_exceptions.dart';
import 'package:f_store_dashboard/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Fetch Banners
  Future<List<BannerModel>> getAllBanners() async {
    try {
      final banners = await _db.collection('Banners').get();
      return banners.docs
          .map((banner) => BannerModel.fromSnapshot(banner))
          .toList();
    } on FirebaseException catch (e) {
      throw FFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatException();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching banners. Please try again';
    }
  }

 // Create Banner
  Future<String> createBanner(BannerModel banner) async {
    try{
      final docRef = await _db.collection('Banners').add(banner.toJson());
      return docRef.id;
    }on FirebaseException catch (e) {
      throw FFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatException();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while creating the banner. Please try again';
    }
  }

  // Update Banner
  Future<void> updateBanner(BannerModel banner) async {
    try{
      await _db.collection('Banners').doc(banner.id).update(banner.toJson());
    }on FirebaseException catch (e) {
      throw FFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatException();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while updating the banner. Please try again';
    }
  }

  // Delete Banner
  Future<void> deleteBanner(String bannerId) async {
    try {
      return await _db.collection('Banners').doc(bannerId).delete();
    } on FirebaseException catch (e) {
      throw FFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatException();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while deleting the banner. Please try again';
    }
  }
}
