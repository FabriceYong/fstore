import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_store_dashboard/utils/formatters/formatters.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;
  DateTime? createdAt;
  DateTime? updatedAt;

  CategoryModel(
      {required this.id,
      required this.name,
      required this.image,
      this.parentId = '',
      this.isFeatured = false,
      this.createdAt,
      this.updatedAt});

  // Formatted Date
  String get formattedCreatedAtDate => FFormatter.formatDate(createdAt);
  String get formattedUpdatedAt => FFormatter.formatDate(updatedAt);

  // Empty Model
  static CategoryModel empty() => CategoryModel(id: '', name: '', image: '');

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt = DateTime.now(),
    };
  }

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() != null) {
      final data = snapshot.data()!;
      return CategoryModel(
        id: snapshot.id,
        name: data.containsKey('Name') ? data['Name'] : '',
        image: data.containsKey('Image') ? data['Image'] : '',
        parentId: data.containsKey('ParentId') ? data['ParentId'] : '',
        isFeatured: data.containsKey('IsFeatured') ? data['IsFeatured'] : false,
        createdAt: data.containsKey('CreatedAt')
            ? (data['CreatedAt'] as Timestamp?)?.toDate()
            : null,
        updatedAt: data.containsKey('UpdatedAt')
            ? (data['UpdatedAt'] as Timestamp?)?.toDate()
            : null,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
