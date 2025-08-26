import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsModel {
  final String? id;
  double taxRate;
  double shippingCost;
  double? freeShippingThreshold;
  String appName;
  String appLogo;

  SettingsModel({
    this.id, this.taxRate = 0.0, this.shippingCost = 0.0, this.freeShippingThreshold, this.appName = '', this.appLogo = ''
  });

  Map<String, dynamic> toJson() {
    return {
      'taxRate': taxRate,
      'shippingCost': shippingCost,
      'freeShippingThreshold': freeShippingThreshold,
      'appName': appName,
      'appLogo': appLogo,
    };
  }

  factory SettingsModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    if(snapshot.data() != null){
      final data = snapshot.data()!;
      return SettingsModel(
        id: snapshot.id,
        taxRate: data.containsKey('taxRate') ? double.parse((data['taxRate'] ?? 0.0).toString()) : 0.0,
        shippingCost: data.containsKey('shippingCost') ? double.parse((data['shippingCost'] ?? 0.0).toString()) : 0.0,
        freeShippingThreshold: data.containsKey('freeShippingThreshold') ? double.parse((data['freeShippingThreshold'] ?? 0.0).toString()) : 0.0,
        appName: data.containsKey('appName') ? data['appName'] : '',
        appLogo: data.containsKey('appLogo') ? data['appLogo'] : '',
      );
    }else {
      return SettingsModel();
    }
  }
}