import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String id;
  String imageUrl;
  bool active;

  BannerModel({
    required this.id,
    required this.imageUrl,
    required this.active,
  });

  /// Static function to create an empty Banner model.
  static BannerModel empty() => BannerModel(id: '', imageUrl: '', active: false);

  /// Convert model to JSON structure for storing in Firebase.
  toJson() {
    return {
      'ImageUrl': imageUrl,
      'Active': active,
    };
  }

  /// Factory method to create a BannerModel from a Firebase document snapshot.
  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
      id: snapshot.id,
      imageUrl: data['ImageUrl'] ?? '',
      active: data['Active'] ?? false,
    );
  }
}
