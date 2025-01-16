class ProductModel{
  final String id;
  final String title;
  final String category;
  final String description;

  ProductModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
  });

  static ProductModel empty() => ProductModel(id: '', title: '', category: '', description: '');
}