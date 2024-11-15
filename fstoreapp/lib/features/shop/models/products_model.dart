import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fstoreapp/features/shop/models/brand_model.dart';
import 'package:fstoreapp/features/shop/models/product_attributes_model.dart';
import 'package:fstoreapp/features/shop/models/product_variations_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku; // stock keeping unit
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributesModel>? productAttributes;
  List<ProductVariationsModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.sku,
    this.brand,
    this.date,
    this.images,
    this.salePrice = 0.0,
    this.isFeatured,
    this.categoryId,
    this.description,
    this.productAttributes,
    this.productVariations,
  });

  /// Create Empty function for clean code
  static ProductModel empty() => ProductModel(
      id: '', title: '', stock: 0, price: 0.0, thumbnail: '', productType: '');

  /// Json Format
  Map<String, dynamic> toJson() {
    return {
      'SKU': sku,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'SalePrice': salePrice,
      'Thumbnail': thumbnail,
      'Images': images ?? [],
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Brand': brand!.toJson(),
      'Description': description,
      'ProductType': productType,
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'ProductVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductModel.empty();

    final data = document.data();
    return ProductModel(
      id: document.id,
      sku: data!.containsKey('SKU') ? data['SKU'] : '',
      title: data.containsKey('Title') ? data['Title'] : '',
      stock: data.containsKey('Stock') ? data['Stock'] : 0,
      isFeatured: data.containsKey('IsFeatured') ? data['IsFeatured'] : false,
      price: data.containsKey('Price')
          ? double.parse((data['Price'] ?? 0.0).toString())
          : 0.0,
      salePrice: data.containsKey('SalePrice')
          ? double.parse((data['SalePrice'] ?? 0.0).toString())
          : 0.0,
      thumbnail: data.containsKey('Thumbnail') ? data['Thumbnail'] : '',
      categoryId: data.containsKey('CategoryId') ? data['CategoryId'] : '',
      description: data.containsKey('Description') ? data['Description'] : '',
      productType: data.containsKey('ProductType') ? 
      data['ProductType'] : '',
      brand: data.containsKey('Brand')
          ? BrandModel.fromJson(data['Brand'])
          : BrandModel.empty(),
      images: data.containsKey('Images')
          ? data['Images'] != null
              ? List<String>.from(data['Images'])
              : []
          : [],
      productAttributes: data.containsKey('ProductAttributes')
          ? (data['ProductAttributes'] as List<dynamic>)
              .map((e) => ProductAttributesModel.fromJson(e))
              .toList()
          : [],
      productVariations: data.containsKey('ProductVariations')
          ? (data['ProductVariations'] as List<dynamic>)
              .map((e) => ProductVariationsModel.fromJson(e))
              .toList()
          : [],
    );
  }

  /// Map Json-oriented document snapshot from Firebase to Model
  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    if (document.data() == null) return ProductModel.empty();

    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      sku: data['SKU'] ?? '',
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributesModel.fromJson(e))
          .toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationsModel.fromJson(e))
          .toList(),
    );
  }
}
