import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_store_dashboard/features/shop/models/category_model/category_model.dart';
import 'package:f_store_dashboard/utils/formatters/formatters.dart';

class BrandModel {
   String id;
   String name;
   String image;
   bool isFeatured;
   int? productsCount;
   DateTime? createdAt;
   DateTime? updatedAt;

      // Not Mapped
      List<CategoryModel>? brandCategories;

  BrandModel(
      {required this.id,
      required this.name,
      required this.image,
      this.isFeatured = false,
      this.brandCategories,
      this.productsCount,
      this.createdAt,
      this.updatedAt});


  static BrandModel empty() => BrandModel(id: '', name: '', image: '');
  String get formattedCreatedAtDate => FFormatter.formatDate(createdAt);
  String get formattedUpdatedAtDate => FFormatter.formatDate(updatedAt);

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'IsFeatured': isFeatured,
      'ProductsCount': productsCount,
      'CreatedAt': createdAt,
      'UpdatedAt': DateTime.now(),
    };
  }

  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() != null) {
      final data = snapshot.data()!;
      return BrandModel(
        id: snapshot.id,
        name: data.containsKey('Name') ? data['Name'] : '',
        image: data.containsKey('Image') ? data['Image'] : '',
        isFeatured: data.containsKey('IsFeatured') ? data['IsFeatured'] : false,
        // category: data.containsKey('Category') ? CategoryModel.fromSnapshot(data['Categories']) : null,
        productsCount:
            data.containsKey('ProductsCount') ? data['ProductsCount'] : 0,
        createdAt: data.containsKey('CreatedAt')
            ? (data['CreatedAt'] as Timestamp?)?.toDate()
            : null,
        updatedAt: data.containsKey('UpdatedAt')
            ? (data['UpdatedAt']as Timestamp?)?.toDate()
            : null,
      );
    } else {
      return BrandModel.empty();
    }
  }

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
        id: json['Id'],
        name: json['Name'],
        image: json['Image'],
        isFeatured: json['IsFeatured'],
        productsCount: json['ProductsCount'],
        createdAt: json['CreatedAt'],
        updatedAt: json['UpdatedAt']);
  }
}
