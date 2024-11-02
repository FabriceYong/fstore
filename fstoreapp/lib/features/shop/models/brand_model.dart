import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel(
      {required this.id,
      required this.image,
      required this.name,
      this.isFeatured,
      this.productsCount});

  /// Empty Helper Function
  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured,
    };
  }

  factory BrandModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BrandModel(
        id: data['Id'] ?? '',
        image: data['Image'] ?? '',
        name: data['Name'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        productsCount: data['ProductsCount'] ?? 0);
  }

  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
        id: data['Id'] ?? '',
        image: data['Image'] ?? '',
        name: data['Name'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        productsCount: data['ProductsCount'] ?? 0);
  }
}
