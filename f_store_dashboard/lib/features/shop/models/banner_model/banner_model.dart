import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_store_dashboard/utils/formatters/formatters.dart';

class BannerModel {
  String id;
  String imageUrl;
  String targetScreen;
  bool active;
  DateTime? createdAt;
  DateTime? updatedAt;

  BannerModel({
    required this.id,
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
    this.createdAt,
    this.updatedAt,
  });

  static BannerModel empty() =>
      BannerModel(id: '', imageUrl: '', targetScreen: '', active: false);
  String get formattedCreatedAtDate => FFormatter.formatDate(createdAt);
  String get formattedUpdatedAtDate => FFormatter.formatDate(updatedAt);

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'ImageUrl': imageUrl,
      'TargetScreen': targetScreen,
      'Active': active,
      'CreatedAt': createdAt,
      'UpdatedAt': DateTime.now(),
    };
  }

  factory BannerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() != null) {
      final data = snapshot.data()!;
      return BannerModel(
          id: snapshot.id,
          imageUrl: data.containsKey('ImageUrl') ? data['ImageUrl'] : '',
          targetScreen: data.containsKey('TargetScreen') ? data['TargetScreen'] : '',
          active: data.containsKey('Active') ? data['Active'] : false,
          createdAt: data.containsKey('CreatedAt')
              ? (data['CreatedAt'] as Timestamp?)?.toDate()
              : null,
          updatedAt: data.containsKey('UpdatedAt')
              ? (data['UpdatedAt'] as Timestamp?)?.toDate()
              : null);
    }
    {
      return BannerModel.empty();
    }
  }
}
