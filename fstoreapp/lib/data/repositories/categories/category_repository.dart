import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fstoreapp/data/services/firebase_storage_service.dart';
import 'package:fstoreapp/features/shop/models/category_model.dart';
import 'package:fstoreapp/utils/exceptions/firebase_exceptions.dart';
import 'package:fstoreapp/utils/exceptions/platform_exceptions.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get all Categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something unexpected went wrong: $e';
    }
  }

  ///Get Sub Categories
  ///
  ///Upload Categories to the Cloud Firestore
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      // Upload all the Categories along with their Images
      final storage = Get.put(FFirebaseStorageService());

      // loop through each category
      for (var category in categories) {
        // Get ImageData link from the local assets
        final file = await storage.getImageDataFromAssets(category.image);

        // upload Image and Get its URL
        final url =
            await storage.uploadImageData('Categories', file, category.name);

        // Assign URL to Category.image attribute
        category.image = url;

        // Store Category in Firestore
        await _db
            .collection('Categories')
            .doc(category.id)
            .set(category.toJson());
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
