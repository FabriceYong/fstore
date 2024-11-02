import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/common/widgets/icons/circular_icon.dart';
import 'package:fstoreapp/common/widgets/layouts/grid-layout.dart';
import 'package:fstoreapp/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:fstoreapp/features/shop/screens/home/home.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          FCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
          child: Column(
            children: [
              FGridLayout(
                  itemCount: 6,
                  itemBuilder: (context, index) =>  FProductCardVertical(product: ProductModel.empty()))
            ],
          ),
        ),
      ),
    );
  }
}
