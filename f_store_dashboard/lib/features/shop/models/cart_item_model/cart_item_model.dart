class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  double totalAmount;
  Map<String, String>? selectedVariations;

  /// Constructor
  CartItemModel({
    required this.productId,
    required this.quantity,
    this.variationId = '',
    this.image,
    this.price = 0.0,
    this.title = '',
    this.totalAmount = 0.0,
    this.brandName,
    this.selectedVariations,
  });

  /// Empty Model
  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  /// Covert a CartItem to Json map
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'variationId': variationId,
      'image': image,
      'price': price,
      'title': title,
      'totalAmount': totalAmount,
      'brandName': brandName,
      'selectedVariations': selectedVariations,
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
        totalAmount: json['totalAmount'],
        brandName: json['brandName'],
        selectedVariations: json['selectedVariations'] != null
            ? Map<String, String>.from(json['selectedVariations'])
            : null);
  }
}
