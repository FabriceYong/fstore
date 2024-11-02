import 'package:f_store_dashboard/utils/constants/enums.dart';

class OrderModel {
  final String id;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final DateTime deliveredDate;

  OrderModel({ required this.id, required this.status, required this.totalAmount, required this.orderDate, required this.deliveredDate});
}