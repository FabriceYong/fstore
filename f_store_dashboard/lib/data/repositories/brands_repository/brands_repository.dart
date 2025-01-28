import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_store_dashboard/features/shop/models/brand_model/brand_model.dart';
import 'package:f_store_dashboard/utils/exceptions/firebase_exceptions.dart';
import 'package:f_store_dashboard/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BrandsRepository extends GetxController {
  static BrandsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      return snapshot.docs
          .map((brand) => BrandModel.fromSnapshot(brand))
          .toList();
    } on FirebaseException catch (e) {
      throw FFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching brands. Please try again later';
    }
  }
}
