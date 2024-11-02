import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fstoreapp/data/services/firebase_storage_service.dart';
import 'package:fstoreapp/features/shop/models/banner_model.dart';
import 'package:fstoreapp/utils/exceptions/firebase_exceptions.dart';
import 'package:fstoreapp/utils/exceptions/format_exceptions.dart';
import 'package:fstoreapp/utils/exceptions/platform_exceptions.dart';
import 'package:get/get.dart';

class BannersRepository extends GetxController {
  static BannersRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get all orders related to current user
  Future<List<BannerModel>> fetchBanners() async {
    try {
      // Get all banners where 'Active' is true
      final result = await _db
          .collection('Banners')
          .where('Active', isEqualTo: true)
          .get();
      return result.docs
          .map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching banners';
    }
  }

  /// Upload Banners to the Cloud FirebaseFirestore
  Future<void> uploadDummyData(List<BannerModel> banners) async {
    try {
      // Upload all the Banners along with their Images
      final storage = Get.put(FFirebaseStorageService());

      // loop through each banner
      for (var banner in banners) {
        // Get ImageData link from the local assets
        final file = await storage.getImageDataFromAssets(banner.imageUrl);

        // upload Image and Get its URL
        final url =
            await storage.uploadImageData('Banners', file, banner.targetScreen);

        // Assign URL to banner.image attribute
        banner.imageUrl = url;

        // Store Banner in Firestore
        await _db.collection('Banners').add(banner.toJson());
      }
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something unexpected went wrong, Please try again';
    }
  }
}
