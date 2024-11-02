import 'package:f_store_dashboard/features/shop/models/order_model/order_model.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final RxList<double> weeklySales = <double>[].obs;

  /// -- Order
  static final List<OrderModel> orders = [
    OrderModel(
        id: 'CWF0012',
        status: OrderStatus.processing,
        totalAmount: 265,
        orderDate: DateTime.now().subtract(const Duration(days: 3)),
        deliveredDate: DateTime.now().add(const Duration(days: 2))),
    OrderModel(
        id: 'CWF0013',
        status: OrderStatus.processing,
        totalAmount: 265,
        orderDate: DateTime.now().subtract(const Duration(days: 1)),
        deliveredDate: DateTime.now().add(const Duration(days: 2))),
    OrderModel(
        id: 'CWF0045',
        status: OrderStatus.shipped,
        totalAmount: 2259,
        orderDate: DateTime.now().subtract(const Duration(days: 3)),
        deliveredDate: DateTime.now().add(const Duration(days: 3))),
    OrderModel(
        id: 'CWF0064',
        status: OrderStatus.delivered,
        totalAmount: 562,
        orderDate: DateTime.now().subtract(const Duration(days: 2)),
        deliveredDate: DateTime.now().add(const Duration(days: 2))),
    OrderModel(
        id: 'CWF0034',
        status: OrderStatus.delivered,
        totalAmount: 9865,
        orderDate: DateTime.now().subtract(const Duration(days: 2)),
        deliveredDate: DateTime.now().add(const Duration(days: 3))),
    OrderModel(
        id: 'CWF0024',
        status: OrderStatus.shipped,
        totalAmount: 2154,
        orderDate: DateTime.now().subtract(const Duration(days: 3)),
        deliveredDate: DateTime.now().add(const Duration(days: 2))),
    OrderModel(
        id: 'CWF0036',
        status: OrderStatus.pending,
        totalAmount: 5462,
        orderDate: DateTime.now().subtract(const Duration(days: 2)),
        deliveredDate: DateTime.now().add(const Duration(days: 4))),
  ];

  @override
  void onInit() {
    _calculateWeeklySales();
    super.onInit();
  }

  // Calculate weekly sales
  void _calculateWeeklySales() {
    //Reset weeklySales to zeros
    weeklySales.value = List<double>.filled(7, 0.0);
    for (var order in orders) {
      final DateTime orderWeekStart =
          FHelperFunctions.getStartOfWeek(order.orderDate);
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
}
