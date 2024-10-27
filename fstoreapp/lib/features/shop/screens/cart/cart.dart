import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:fstoreapp/features/shop/screens/checkout/checkout.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(FSizes.defaultSpace / 2),
        child: FCartItems(),
      ),
      bottomNavigationBar: ElevatedButton(
          onPressed: () => Get.to(() => const CheckoutScreen()),
          child: const Text('Checkout \$3500.45')),
    );
  }
}
