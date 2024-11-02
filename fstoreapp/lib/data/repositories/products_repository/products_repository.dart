import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fstoreapp/data/services/firebase_storage_service.dart';
import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:fstoreapp/utils/constants/enums.dart';
import 'package:fstoreapp/utils/exceptions/firebase_exceptions.dart';
import 'package:fstoreapp/utils/exceptions/platform_exceptions.dart';
import 'package:get/get.dart';

/// Repository for managing product-related data and operaations
class ProductsRepository extends GetxController {
  static ProductsRepository get instance => Get.find();

  /// Firebase instance for database interactions
  final _db = FirebaseFirestore.instance;

  /// Get Limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();
      return snapshot.docs
          .map((document) => ProductModel.fromSnapshot(document))
          .toList();
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///
  /// Upload dummy data to the Cloud Firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      //Upload all the products along with their images
      final storage = Get.put(FFirebaseStorageService());

      // Loop through each product
      for (var product in products) {
        // Get Image link from local assets
        final thumbnail =
            await storage.getImageDataFromAssets(product.thumbnail);
        // Upload image and get its URL
        final url = await storage.uploadImageData(
            'Products/Images', thumbnail, product.thumbnail.toString());

        // Assign URL to product.thumbnail attribute
        product.thumbnail = url;

        // Product list of images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imagesUrl = [];
          for (var image in product.images!) {
            // Get Image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(image);

            // Upload image and get its URL
            final url = await storage.uploadImageData(
                'Products/Images', assetImage, image);

            // Assign URL to product.thumbnail attribute
            imagesUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imagesUrl);
        }

        // Upload Variation Images
        if (product.productType == ProductType.variable.toString()) {
          for (var variation in product.productVariations!) {
            // Get image data link from local assets
            final assetImage =
                await storage.getImageDataFromAssets(variation.image);

            // Upload image and get its URL
            final url = await storage.uploadImageData(
                'Products/Images', assetImage, variation.image);

            // Assign URL to variation.image attribute
            variation.image = url;
          }
        }
        // Store product in FireStore
        await _db.collection('Products').doc(product.id).set(product.toJson());
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
