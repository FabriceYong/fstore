class ProductAttributesModel {
  String? name;
  final List<String>? values;

ProductAttributesModel({this.name, this.values});

  Map<String, dynamic> toJson(){
    return {'Name': name,
    'Values': values ?? []};
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductAttributesModel.fromJson(Map<String, dynamic> json){
    final data = json;

    if(data.isEmpty) return ProductAttributesModel();
    return ProductAttributesModel(name: data.containsKey('Name') ? data['Name'] : '', values: List<String>.from(data['Values']));
  }
}