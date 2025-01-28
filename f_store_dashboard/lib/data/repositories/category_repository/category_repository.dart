import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_store_dashboard/features/shop/models/category_model/category_model.dart';
import 'package:f_store_dashboard/utils/exceptions/firebase_exceptions.dart';
import 'package:f_store_dashboard/utils/exceptions/format_exceptions.dart';
import 'package:f_store_dashboard/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      return snapshot.docs
          .map((category) => CategoryModel.fromSnapshot(category))
          .toList();
    } on FirebaseException catch (e) {
      throw FFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      print(e);
      throw 'Something went wrong while fetching categories. Please try again.';
    }
  }

  // Create New Category
  Future<String> createCategory(CategoryModel newCategory) async {
    try {
      final category =
          await _db.collection('Categories').add(newCategory.toJson());
      return category.id;
    } on FirebaseException catch (e) {
      throw FFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatException();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while deleting the category. Please try again';
    }
  }

  // Update Category
  Future<void> updateCategory(CategoryModel category) async {
    try {
      await _db
          .collection('Categories')
          .doc(category.id)
          .update(category.toJson());
    } on FirebaseException catch (e) {
      throw FFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatException();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while deleting the category. Please try again';
    }
  }

  // Delete an existing category document from the 'Categories' Repository.
  Future<void> deleteCategory(String categoryId) async {
    try {
      await _db.collection('Categories').doc(categoryId).delete();
    } on FirebaseException catch (e) {
      throw FFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatException();
    } on PlatformException catch (e) {
      throw FPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while deleting the category. Please try again';
    }
  }
}
