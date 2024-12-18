import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_store_dashboard/utils/formatters/formatters.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart';

class ImageModel {
  String id;
  final String url;
  final String folder;
  final int? sizeBytes;
  String mediaCategory;
  final String filename;
  final String? fullPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;

  // Not Mapped
  final DropzoneFileInterface? file;
  RxBool isSelected = false.obs;
  final Uint8List? localImageToDisplay;

  /// Constructor for ImageModel
  ImageModel(
      {this.id = '',
      required this.folder,
      required this.url,
      this.sizeBytes,
      this.mediaCategory = '',
      required this.filename,
      this.fullPath,
      this.createdAt,
      this.updatedAt,
      this.contentType,
      this.file,
      this.localImageToDisplay});

  /// Static function to create an empty user Model
  static ImageModel empty() => ImageModel(folder: '', url: '', filename: '');

  String get createdAtFormatted => FFormatter.formatDate(createdAt);
  String get updatedAtFormatted => FFormatter.formatDate(updatedAt);

  /// Convert to JSON to Store in DB
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'folder': folder,
      'sizeBytes': sizeBytes,
      'mediaCategory': mediaCategory,
      'filename': filename,
      'fullPath': fullPath,
      'createdAt': createdAt?.toUtc(),
      'updatedAt': updatedAt,
      'contentType': contentType,
    };
  }

  /// Convert Firestore Json and Map on Model
  factory ImageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // Map JSON Record to the Model
      return ImageModel(
          id: document.id,
          url: data['url'] ?? '',
          folder: data['folder'] ?? '',
          sizeBytes: data['sizeBytes'] ?? 0,
          mediaCategory: data['mediaCategory'] ?? '',
          filename: data['filename'] ?? '',
          fullPath: data['fullPath'] ?? '',
          createdAt: data.containsKey('createdAt')
              ? data['createdAt']?.toDate()
              : null,
          updatedAt: data.containsKey('updatedAt')
              ? data['updatedAt']?.toDate()
              : null,
          contentType: data['contentType']);
    } else {
      return ImageModel.empty();
    }
  }

  /// Map Firebase Storage Data
  factory ImageModel.fromFirebaseMetaData(FullMetadata metadata, String folder,
      String filename, String downloadUrl) {
    return ImageModel(
        url: downloadUrl,
        folder: folder,
        filename: filename,
        sizeBytes: metadata.size,
        updatedAt: metadata.updated,
        fullPath: metadata.fullPath,
        createdAt: metadata.timeCreated,
        contentType: metadata.contentType);
  }
}
