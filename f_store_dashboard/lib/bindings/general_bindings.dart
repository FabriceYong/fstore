import 'package:f_store_dashboard/features/authentication/controllers/user_controller.dart';
import 'package:f_store_dashboard/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies(){
    /// -- Core
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
  }
}