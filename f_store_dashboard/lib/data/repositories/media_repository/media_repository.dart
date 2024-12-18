import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_store_dashboard/features/media/models/image_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  // Firebase Storage Instance
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  // Upload any image using File
  Future<ImageModel> uploadImageFileInStorage(
      {required DropzoneViewController dropzoneController,
      required DropzoneFileInterface file,
      required String path,
      required String imageName}) async {
    try {
      // Reference to the storage location
      final firebase_storage.Reference ref = _storage.ref('$path/$imageName');

      // Get bytes from DropzoneFileInterface

      Uint8List fileBytes = await dropzoneController.getFileData(file);

      // use the blob with putBlob
      final html.Blob blob = html.Blob([fileBytes], 'image/jpeg');

      // Upload file
      firebase_storage.TaskSnapshot uploadTask = await ref.putBlob(
          blob, firebase_storage.Settable8Metadata(contentType: 'image/jpeg'));
      print(uploadTask);

      // Get Download URL
      final String downloadUrl = await ref.getDownloadURL();

      // Fetch Meta Data
      final firebase_storage.FullMetadata metadata = await ref.getMetadata();

      return ImageModel.fromFirebaseMetaData(
          metadata, path, imageName, downloadUrl);
    } on firebase_storage.FirebaseException catch (e) {
      print('Firebase Storage Exception: ${e.code}, ${e.message}');
      // throw e.message!;
      rethrow;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  // Upload Image data in Firestore
  Future<String> uploadImageFileInDatabase(ImageModel image) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection('Images')
          .add(image.toJson());
      return data.id;
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
