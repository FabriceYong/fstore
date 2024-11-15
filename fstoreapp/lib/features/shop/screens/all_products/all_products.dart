import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/common/widgets/products/sortable/sortable_products.dart';
import 'package:fstoreapp/common/widgets/schimmers/vertical_product_shimmer.dart';
import 'package:fstoreapp/features/shop/controllers/all_products_controller.dart';
import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/cloud_helper_functions.dart';
import 'package:get/get.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    return Scaffold(
      appBar: const FAppBar(
        title: Text('All Products'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
          child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductsByQuery(query),
              builder: (context, snapshot) {
                final widget = FCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: const FVerticalProductShimmer(itemCount: 6));

                // Return appropriate widget based on snapshot state
                if (widget != null) return widget;

                // Products Found!
                final products = snapshot.data!;
                print('Home Products: $products');

                return FSortableProducts(products: products);
              }),
        ),
      ),
    );
  }
}
