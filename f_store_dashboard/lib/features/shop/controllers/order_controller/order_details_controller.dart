import 'package:f_store_dashboard/data/models/user_model.dart';
import 'package:f_store_dashboard/data/repositories/user/user_repository.dart';
import 'package:f_store_dashboard/features/shop/models/order_model/order_model.dart';
import 'package:f_store_dashboard/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class OrderDetailsController extends GetxController{
  static OrderDetailsController get instance => Get.find();

  RxBool loading = false.obs;
  Rx<UserModel> customer = UserModel.empty().obs;
  Rx<OrderModel> order = OrderModel.empty().obs;

  /// Load Customer Orders
  Future<void> getCustomerOfCurrentOrder() async {
    try{
      loading.value = true;
      // Fetch customer orders and Addresses
      final user = await Get.find<UserRepository>().fetchUserDetails(order.value.userId);
    }catch(e){
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }finally{
      loading.value = false;
    }
  }
}