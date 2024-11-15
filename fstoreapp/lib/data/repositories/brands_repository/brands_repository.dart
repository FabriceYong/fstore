import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fstoreapp/data/services/firebase_storage_service.dart';
import 'package:fstoreapp/features/shop/models/brand_model.dart';
import 'package:fstoreapp/utils/exceptions/firebase_exceptions.dart';
import 'package:fstoreapp/utils/exceptions/format_exceptions.dart';
import 'package:fstoreapp/utils/exceptions/platform_exceptions.dart';
import 'package:get/get.dart';

class BrandsRepository extends GetxController {
  static BrandsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Get a limited number of brands
  Future<List<BrandModel>> getFeaturedBrands() async {
    try {
      final snapshot = await _db
          .collection('Brands')
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();
      return snapshot.docs
          .map((document) => BrandModel.fromSnapshot(document))
          .toList();
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something unexpected went wrong: $e';
    }
  }

  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      return snapshot.docs
          .map((document) => BrandModel.fromSnapshot(document))
          .toList();
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something unexpected went wrong: $e';
    }
  }

  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      // Query to get all documents where categoryId matches the provided categoryId
      QuerySnapshot brandCategoryQuery = await _db
          .collection('BrandCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      // Extract brands from the document
      List<String> brandIds = brandCategoryQuery.docs
          .map((document) => document['brandId'] as String)
          .toList();

      // Query to get all documents where the brandId is in the list of brandIds, FieldPath.documentId to query documents in Collection
      final brandsQuery = await _db
          .collection('Brands')
          .where(FieldPath.documentId, whereIn: brandIds)
          .limit(2)
          .get();

      // Extract brand names or other relevant data from the documents
      List<BrandModel> brands = brandsQuery.docs
          .map((document) => BrandModel.fromSnapshot(document))
          .toList();

      return brands;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something unexpected went wrong: $e';
    }
  }

  Future<List<BrandModel>> getAllFeaturedBrands() async {
    try {
      final snapshot = await _db
          .collection('Brands')
          .where('IsFeatured', isEqualTo: true)
          .get();
      return snapshot.docs
          .map((document) => BrandModel.fromSnapshot(document))
          .toList();
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something unexpected went wrong: $e';
    }
  }

  Future<void> uploadDummyData(List<BrandModel> brands) async {
    try {
      final storage = Get.put(FFirebaseStorageService());

      for (var brand in brands) {
        final file = await storage.getImageDataFromAssets(brand.image);
        final url = await storage.uploadImageData('Brands', file, brand.name);
        brand.image = url;
        await _db.collection('Brands').doc(brand.id).set(brand.toJson());
      }
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something unexpected went wrong: $e';
    }
  }
}
