class PaymentMethodModel {
  final String name;
  final String image;

  PaymentMethodModel({
    required this.name,
    required this.image,
  });

  factory PaymentMethodModel.empty() {
    return PaymentMethodModel(
      name: '',
      image: '',
    );
  }
  
}

