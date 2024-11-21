import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/success_screen/success_screen.dart';
import 'package:fstoreapp/data/repositories/authentication/authentication_repository.dart';
import 'package:fstoreapp/data/repositories/order_repository/order_repository.dart';
import 'package:fstoreapp/features/personalization/controllers/address_controller/address_controller.dart';
import 'package:fstoreapp/features/shop/controllers/product/cart_controller.dart';
import 'package:fstoreapp/features/shop/controllers/product/checkout_controller.dart';
import 'package:fstoreapp/features/shop/models/order_model.dart';
import 'package:fstoreapp/features/shop/screens/home/home.dart';
import 'package:fstoreapp/navigation_menu.dart';
import 'package:fstoreapp/utils/constants/enums.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/loaders/full_screen_loader.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  /// Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  /// Fetch User's Order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
      return [];
    }
  }

  /// Add Methods for order processing
  void processOrder(double totalAmount) async {
    try {
      // Start Loader
      FFullScreenLoader.openLoadingDialog(
          'Processing your Order', FImages.pencilAnimation);

      // Get user authentication Id
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      // Add Details
      final order = OrderModel(
          id: UniqueKey().toString(),
          status: OrderStatus.pending,
          totalAmount: totalAmount,
          orderDate: DateTime.now(),
          deliveryDate: DateTime.now(),
          paymentMethod: checkoutController.selectedPaymentMethod.value.name,
          address: addressController.selectedAddress.value,
          items: cartController.cartItems.toList());

      // Save the order to Firestore
      await orderRepository.saveOrder(order, userId);

      // Update the cart status
      cartController.clearCart();

      // Show success screen
      Get.off(
        () => SuccessScreen(
          image: FImages.orderCompleteAnimation,
          title: 'Payment Success!',
          subTitle: 'Your item will be shipped soon!',
          onPressed: () => Get.offAll(
            () => const NavigationMenu(),
          ),
        ),
      );
    } catch (e) {
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }
}
