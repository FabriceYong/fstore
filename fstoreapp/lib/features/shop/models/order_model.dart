import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fstoreapp/data/models/address_model/address_model.dart';
import 'package:fstoreapp/features/shop/models/cart_item_model.dart';
import 'package:fstoreapp/utils/constants/enums.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime? orderDate;
  final AddressModel? address;
  final String paymentMethod;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel(
      {required this.id,
      this.userId = '',
      required this.status,
      required this.totalAmount,
      required this.orderDate,
      this.address,
      this.paymentMethod = 'Paypal',
      required this.deliveryDate,
      required this.items});

  String get formattedOrderDate =>
      FHelperFunctions.getFormattedDate(orderDate ?? DateTime.now());

  String get formattedDeliveryDate =>
      FHelperFunctions.getFormattedDate(deliveryDate ?? DateTime.now());

  String get orderStatus => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Processing';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'address': address?.toJson(),
      'paymentMethod': paymentMethod,
      'deliveryDate': deliveryDate,
      'items': items
          .map((item) => item.toJson())
          .toList() // Convert cArtModel to Map
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
        id: data['id'] as String,
        userId: data['userId'] as String,
        status: OrderStatus.values
            .firstWhere((e) => e.toString() == data['status']),
        totalAmount: data['totalAmount'] as double,
        orderDate: (data['orderDate'] as Timestamp?)?.toDate(),
        paymentMethod: data['paymentMethod'] as String,
        address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
        deliveryDate: (data['deliveryData'] as Timestamp?)?.toDate(),
        items: (data['items'] as List<dynamic>)
            .map((itemData) =>
                CartItemModel.fromJson(itemData as Map<String, dynamic>))
            .toList());
  }
}
