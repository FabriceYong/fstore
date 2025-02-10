import 'package:cloud_firestore/cloud_firestore.dart';

class BrandCategoryModel {
  String id;
  String brandId;
  String categoryId;

  BrandCategoryModel({required this.id, required this.brandId, required this.categoryId});

  static BrandCategoryModel empty() => BrandCategoryModel(brandId: '', categoryId: '', id: '');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brandId': brandId,
      'categoryId': categoryId,
    };
  }

  factory BrandCategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    if(snapshot.data() != null){
      final data = snapshot.data()!;
      return BrandCategoryModel(
        id: snapshot.id,
        brandId: data.containsKey('brandId') ? data['brandId']: '',
        categoryId: data.containsKey('categoryId')? data['categoryId'] : '',
      );
    }else{
      return BrandCategoryModel.empty();
    }
  }
}