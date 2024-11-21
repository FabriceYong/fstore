class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, String>? selectedVariations;

  /// Constructor
  CartItemModel({
    required this.productId,
    required this.quantity,
    this.variationId = '',
    this.image,
    this.price = 0.0,
    this.title = '',
    this.brandName,
    this.selectedVariations,
  });

  /// Empty
  static CartItemModel empty() =>
      CartItemModel(productId: 'productId', quantity: 0);

  /// Convert a CartItem to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'variationId': variationId,
      'image': image,
      'price': price,
      'title': title,
      'brandName': brandName,
      'selectedVariations': selectedVariations
    };
  }

  /// Create a CartItem from a JSON Map
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      quantity: json['quantity'],
      variationId: json['variationId'],
      image: json['image'],
      price: json['price'],
      title: json['title'],
      brandName: json['brandName'],
      selectedVariations: json['selectedVariations'] != null
          ? Map<String, String>.from(json['selectedVariations'])
          : null,
    );
  }
}
