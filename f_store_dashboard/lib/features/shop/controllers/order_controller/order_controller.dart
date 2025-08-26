import 'package:f_store_dashboard/data/abstract/base_data_table_controller.dart';
import 'package:f_store_dashboard/data/repositories/order_repository/order_repository.dart';
import 'package:f_store_dashboard/features/shop/models/order_model/order_model.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class OrderController extends FBaseController<OrderModel>{
  static OrderController get instance => Get.find();

  RxBool statusLoader = false.obs;
  Rx<OrderStatus> orderStatus = OrderStatus.pending.obs;
  final _orderRepository = Get.put(OrderRepository());
  
  @override
  bool containsSearchQuery(OrderModel item, String query) {
    return item.id.toLowerCase().contains(query.toLowerCase());
  }
  
  @override
  Future<void> deleteItem(OrderModel item) async {
    await _orderRepository.deleteOrder(item.docId);
  }
  
  @override
  Future<List<OrderModel>> fetchItems() async{
    return await _orderRepository.getAllOrders();
  }
  
  void sortOrderById(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (OrderModel order) => order.totalAmount.toString().toLowerCase());
  }

  void sortOrderByDate(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (OrderModel order) => order.orderDate.toString().toLowerCase());
  }

  Future<void> updateOrderStatus(OrderModel order, OrderStatus newStatus) async {
    try{
      statusLoader.value = true;
      order.status = newStatus;
      await _orderRepository.updateOrderSpecificValues(order.docId, {'Status': newStatus.toString()});
      updateItemInList(order);
      orderStatus.value = newStatus;
      Snackbars.successSnackbar(title: 'Updated', message: 'Order status updated successfully');
    }catch(e){
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }finally{
      statusLoader.value = false;
    }
  } 
}