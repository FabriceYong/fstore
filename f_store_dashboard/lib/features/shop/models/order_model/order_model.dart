import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_store_dashboard/features/shop/models/addresses_model/address_model.dart';
import 'package:f_store_dashboard/features/shop/models/cart_item_model/cart_item_model.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String docId;
  final String userId;
  OrderStatus status;
  final double totalAmount;
  final double shipmentCost;
  final double taxCost;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? shippingAddress;
  final AddressModel? billingAddress;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;
  final bool billingAddressSameAsShipping;


  OrderModel(
      {
        required this.id,
        this.docId = '',
        this.userId = '',
         required this.status,
         required this.items,
         required this.totalAmount,
         required this.shipmentCost,
         required this.taxCost,
         required this.orderDate,
        this.paymentMethod = 'Cash on delivery',
        this.shippingAddress,
        this.billingAddress,
        this.deliveryDate,
        this.billingAddressSameAsShipping = true
      });

      static OrderModel empty() => OrderModel(id: '', status: OrderStatus.pending, items: [], totalAmount: 0, shipmentCost: 0.0, taxCost: 0.0, orderDate: DateTime.now());

  String get formattedOrderDate =>
      FHelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate =>
      FHelperFunctions.getFormattedDate(deliveryDate ?? DateTime.now());

  String get orderStatus => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Processing';

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'UserId': userId,
      'Status': status,
      'DocId': docId,
      'TotalAmount': totalAmount,
      'Items': items.map((item) => item.toJson()),
      'TaxCost': taxCost,
      'ShipmentCost': shipmentCost,
      'OrderDate': orderDate,
      'ShippingAddress': shippingAddress!.toJson(),
      'BillingAddress' : billingAddress!.toJson(),
      'PaymentMethod': paymentMethod,
      'DeliveryDate': deliveryDate,
      'BillingAddressSameAsShipping': billingAddressSameAsShipping,
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if(snapshot.data() == null) return OrderModel.empty();
    final data = snapshot.data()!;
    return OrderModel(
        id: snapshot.id,
        docId: data.containsKey('DocId') ? data['DocId'] : '',
        userId: data.containsKey('UserId') ? data['UserId'] : '',
        status: data.containsKey('OrderStatus') ? OrderStatus.values
            .firstWhere((e) => e.toString() == data['OrderStatus']) : OrderStatus.pending,
        totalAmount: data.containsKey('TotalAmount') ? double.parse((data['TotalAmount'] ?? 0.0).toString()) : 0.0,
        orderDate: data.containsKey('OrderDate') ? (data['OrderDate'] as Timestamp).toDate() : DateTime.now(),
        deliveryDate: data.containsKey('DeliverDate') ? (data['deliveryDate'] as Timestamp?)?.toDate() : null,
        shippingAddress: data.containsKey('ShippingAddress') ? AddressModel.fromMap(data['address'] as Map<String, dynamic>) : AddressModel.empty(),
        billingAddress: data.containsKey('BillingAddress') ? AddressModel.fromMap(data['BillingAddress'] as Map<String, dynamic>) : AddressModel.empty(),
        items: data.containsKey('Items') ? (data['Items'] as List<dynamic>).map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList() : [CartItemModel.empty()],
        shipmentCost: data.containsKey('ShipmentCost') ? double.parse((data['ShipmentCost'] ?? 0.0).toString()): 0.0,
        taxCost: data.containsKey('TaxCost') ? double.parse((data['TaxCost'] ?? 0.0).toString()) : 0.0,
        paymentMethod: data.containsKey('PaymentMethod') ? data['PaymentMethod'] : 'Cash on delivery',
        billingAddressSameAsShipping: data.containsKey('BillingAddressSameAsShipping') ? data['BillingAddressSameAsShipping'] : true,
            );
  }
}
