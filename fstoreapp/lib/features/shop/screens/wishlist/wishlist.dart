import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/common/widgets/icons/circular_icon.dart';
import 'package:fstoreapp/common/widgets/layouts/grid-layout.dart';
import 'package:fstoreapp/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:fstoreapp/common/widgets/schimmers/vertical_product_shimmer.dart';
import 'package:fstoreapp/features/shop/controllers/favourite_controller.dart';
import 'package:fstoreapp/features/shop/screens/home/home.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/cloud_helper_functions.dart';
import 'package:fstoreapp/utils/loaders/animation_loader.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouriteController.instance;
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
              Obx(
                () => FutureBuilder(
                  future: controller.favoriteProducts(),
                  builder: (context, snapshot) {
                    // Nothing found widget
                    final emptyWidget = FAnimationLoaderWidget(
                      text: 'Whoops!, Wishlist is Empty...',
                      animation: FImages.pencilAnimation,
                      showAction: true,
                      actionText: 'Let\'s add some',
                      onActionPressed: () => Get.off(() => const HomeScreen()),
                    );

                    const loader = FVerticalProductShimmer(
                      itemCount: 6,
                    );
                    final widget = FCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot,
                        loader: loader,
                        nothingFound: emptyWidget);

                    if (widget != null) return widget;

                    final products = snapshot.data!;
                    return FGridLayout(
                        itemCount: products.length,
                        itemBuilder: (context, index) =>
                            FProductCardVertical(product: products[index]));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
