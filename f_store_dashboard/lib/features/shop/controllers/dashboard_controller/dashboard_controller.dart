import 'package:f_store_dashboard/data/abstract/base_data_table_controller.dart';
import 'package:f_store_dashboard/features/shop/controllers/customer_controller/customer_controller.dart';
import 'package:f_store_dashboard/features/shop/controllers/order_controller/order_controller.dart';
import 'package:f_store_dashboard/features/shop/models/order_model/order_model.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class DashboardController extends FBaseController<OrderModel> {
  static DashboardController get instance => Get.find();

  final orderController = Get.put(OrderController());
  final customerController = Get.put(CustomerController());

  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatus = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmount = <OrderStatus, double>{}.obs;

  /// -- Order

  @override
  Future<List<OrderModel>> fetchItems() async {
    // Fetch Orders if empty
    if (orderController.allItems.isEmpty) {
      await orderController.fetchItems();
    }

    // Fetch customers if empty
    if (customerController.allItems.isEmpty) {
      await orderController.fetchItems();
    }

    // Calculate Weekly sales
    _calculateWeeklySales();

    // Calculate order status
    _calculateOrderStatusCounts();

    return orderController.allItems;
  }

  // Calculate weekly sales
  void _calculateWeeklySales() {
    //Reset weeklySales to zeros
    weeklySales.value = List<double>.filled(7, 0.0);
    for (var order in orderController.allItems) {
      final DateTime orderWeekStart =
          FHelperFunctions.getStartOfWeek(order.orderDate ?? DateTime.now());
      final DateTime currentWeekStart =
          FHelperFunctions.getStartOfWeek(DateTime.now());

      // Check if the order is within the current week
      // if(orderWeekStart.isBefore(DateTime.now()) && orderWeekStart.add(Duration(days: 7)).isAfter(DateTime.now())) {
      //   int index = (order.orderDate.weekday - 1) % 7;
      if (orderWeekStart == currentWeekStart &&
          order.orderDate
              .isBefore(currentWeekStart.add(const Duration(days: 7)))) {
        int index = (order.orderDate.weekday - 1) % 7;

        // Ensure the index is non-negative
        index = index < 0 ? index + 7 : index;

        weeklySales[index] += order.totalAmount;
        print(
            'OrderDAte: ${order.orderDate}, CurrentWeek: $orderWeekStart, Index: $index');
      }
    }

    print('Weekly Sales: $weeklySales');
  }

  // Call this function to calculate Order status counts
  void _calculateOrderStatusCounts() {
    // Reset status data
    orderStatus.clear();

    // Map to store total amounts for each status
    totalAmount.value = {for (var status in OrderStatus.values) status: 0.0};

    for (var order in orderController.allItems) {
      // Count Orders
      final status = order.status;
      orderStatus[status] = (orderStatus[status] ?? 0) + 1;

      //Calculate total amounts for each status
      totalAmount[status] = totalAmount[status] ?? 0 + order.totalAmount;
    }
  }

  String getDisplayStatusName(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  @override
  bool containsSearchQuery(OrderModel item, String query) {
    // TODO: implement containsSearchQuery
    throw UnimplementedError();
  }

  @override
  Future<void> deleteItem(OrderModel item) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }
}
