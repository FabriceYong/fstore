import 'package:fstoreapp/features/personalization/controllers/address_controller/address_controller.dart';
import 'package:fstoreapp/features/shop/controllers/product/checkout_controller.dart';
import 'package:fstoreapp/features/shop/controllers/product/variation_controller.dart';
import 'package:get/get.dart';

import '../utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(AddressController());
    Get.put(CheckoutController());
  }
}
