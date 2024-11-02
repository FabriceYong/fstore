class ProductVariationsModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, dynamic> attributes;

  ProductVariationsModel(
      {required this.id,
      this.sku = '',
      this.image = '',
      this.description = '',
      this.price = 0.0,
      this.salePrice = 0.0,
      this.stock = 0,
      required this.attributes});

  /// Create Empty function for clean code
  static ProductVariationsModel empty() =>
      ProductVariationsModel(id: '', attributes: {});

  /// Json Format
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Image': image,
      'Description': description,
      'Price': price,
      'SKU': sku,
      'SalePrice': salePrice,
      'Stock': stock,
      'AttributeValues': attributes
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductVariationsModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductVariationsModel.empty();

    return ProductVariationsModel(
        id: data.containsKey('Id') ? data['Id'] : '',
        attributes: data.containsKey('AttributeValues')
            ? Map<String, dynamic>.from(data['AttributeValues'])
            : {},
        sku: data.containsKey('SKU') ? data['SKU'] : '',
        image: data.containsKey('Image') ? data['Image'] : '',
        description: data.containsKey('Description') ? data['Description'] : '',
        price: data.containsKey('Price')
            ? double.parse((data['Price'] ?? 0.0).toString())
            : 0.0,
        salePrice: data.containsKey('SalePrice')
            ? double.parse((data['SalePrice'] ?? 0.0).toString())
            : 0.0,
        stock: data.containsKey('Stock') ? data['Stock'] : 0);
  }
}
