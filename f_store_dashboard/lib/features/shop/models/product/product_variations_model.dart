import 'package:get/get.dart';

class ProductVariationsModel {
  final String id;
  String sku;
  Rx<String> image;
  String? description;
  double price;
  double salePrice;
  int stock;
  int soldQuantity;
  Map<String, String> attributeValues;

  ProductVariationsModel(
      {required this.id,
      this.sku = '',
      String image = '',
      this.description = '',
      this.price = 0.0,
      this.salePrice = 0.0,
      this.stock = 0,
      this.soldQuantity = 0,
      required this.attributeValues})
      : image = image.obs;

  static ProductVariationsModel empty() =>
      ProductVariationsModel(id: '', attributeValues: {});

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'SKU': sku,
      'Image': image.value,
      'Description': description,
      'Price': price,
      'SalePrice': salePrice,
      'Stock': stock,
      'SoldQuantity': soldQuantity,
      'Attributes': attributeValues
    };
  }

  factory ProductVariationsModel.fromJson(Map<String, dynamic> json) {
    final data = json;
    if (data.isEmpty) {
      return ProductVariationsModel(
          id: data.containsKey('Id') ? data['Id'] : '',
          sku: data.containsKey('SKU') ? data['SKU'] : '',
          image: data.containsKey('Image') ? data['Image'] : '',
          description:
              data.containsKey('Description') ? data['Description'] : '',
          price: double.parse((data['Price'] ?? 0.0).toString()),
          salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
          soldQuantity:
              data.containsKey('SoldQuantity') ? data['SoldQuantity'] : 0,
          attributeValues: data.containsKey('Attributes')
              ? Map<String, String>.from(data['Attributes'])
              : {});
    } else {
      return ProductVariationsModel.empty();
    }
  }
}
