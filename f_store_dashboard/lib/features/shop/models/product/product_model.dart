import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_store_dashboard/features/shop/models/brand_model/brand_model.dart';
import 'package:f_store_dashboard/features/shop/models/product/product_attributes_model.dart';
import 'package:f_store_dashboard/features/shop/models/product/product_variations_model.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/formatters/formatters.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool isFeatured;
  BrandModel? brand;
  String? categoryId;
  String productType;
  List<String>? images;
  int soldQuantity;
  String? description;
  List<ProductAttributesModel> productAttributes;
  List<ProductVariationsModel> productVariations;

  ProductModel({
    required this.id,
    required this.stock,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.description,
    this.soldQuantity = 0,
    this.sku,
    this.brand,
    this.date,
    this.images,
    this.salePrice = 0.0,
    this.isFeatured = false,
    List<ProductAttributesModel>? productAttributes,
    List<ProductVariationsModel>? productVariations,
    this.categoryId,
  })  : productAttributes = productAttributes ?? [],
        productVariations = productVariations ?? [];

  /// Empty Constructor
  ProductModel.empty()
      : id = '',
        title = '',
        description = '',
        thumbnail = '',
        price = 0,
        salePrice = 0.0,
        isFeatured = false,
        stock = 0,
        soldQuantity = 0,
        productType = ProductType.single.toString(),
        brand = null,
        productVariations = [],
        productAttributes = [];

  String? get formattedDate => FFormatter.formatDate(date);

  Map<String, dynamic> toJson() {
    return {
      'Stock': stock,
      'Title': title,
      'SKU': sku,
      'Price': price,
      'Date': Timestamp.fromDate(date ?? DateTime.now()),
      'SalePrice': salePrice,
      'Thumbnail': thumbnail,
      'Description': description,
      'IsFeatured': isFeatured,
      'Brand': brand?.toJson(),
      'CategoryId': categoryId,
      'ProductType': productType,
      'Images': images,
      'SoldQuantity': soldQuantity,
      'ProductAttributes':
          productAttributes.map((attribute) => attribute.toJson()).toList(),
      'ProductVariations':
          productVariations.map((variation) => variation.toJson()).toList()
    };
  }

  /// Map Json Oriented Document from Firebase to Model
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() == null) return ProductModel.empty();

    final data = snapshot.data()!;
    return ProductModel(
        id: snapshot.id,
        stock: data.containsKey('Stock') ? data['Stock'] : 0,
        title: data.containsKey('Title') ? data['Title'] : '',
        sku: data.containsKey('SKU') ? data['SKU'] : '',
        price: double.parse((data['Price'] ?? 0.0).toString()),
        date: data.containsKey('Date')
            ? (data['Date'] as Timestamp?)?.toDate()
            : null,
        salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
        thumbnail: data.containsKey('Thumbnail') ? data['Thumbnail'] : '',
        description: data.containsKey('Description') ? data['Description'] : '',
        isFeatured: data.containsKey('IsFeatured') ? data['IsFeatured'] : false,
        brand: data.containsKey('Brand') && data['Brand'] != null
            ? BrandModel.fromJson(data['Brand'])
            : null,
        categoryId: data['CategoryId'] ?? '',
        productType: data.containsKey('ProductType') ? data['ProductType'] : '',
        images: data['Images'] != null ? List.from(data['Images']) : null,
        soldQuantity:
            data.containsKey('SoldQuantity') ? data['SoldQuantity'] ?? 0 : 0,
        productAttributes: data.containsKey('ProductAttributes') &&
                data['ProductAttributes'] != null
            ? (data['ProductAttributes'] as List<dynamic>)
                .map((e) => ProductAttributesModel.fromJson(e))
                .toList()
            : [],
        productVariations: data.containsKey('ProductVariations') &&
                data['ProductVariations'] != null
            ? (data['ProductVariations'] as List<dynamic>)
                .map((e) => ProductVariationsModel.fromJson(e))
                .toList()
            : []);
  }

  /// Map Json Oriented Document from Firebase to Model
  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    if (document.data() == null) return ProductModel.empty();

    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      sku: data['SKU'] ?? '',
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      date: (data['Date'] as Timestamp?)?.toDate(),
      soldQuantity: data['SoldQuantity'] ?? 0,
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
