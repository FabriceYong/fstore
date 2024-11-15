import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/icons/circular_icon.dart';
import 'package:fstoreapp/features/shop/controllers/favourite_controller.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FFavoriteIcon extends StatelessWidget {
  const FFavoriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteController());
    return Obx(
      () => FCircularIcon(
        icon: controller.isFavorite(productId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavorite(productId) ? FColors.error : null,
        onPressed: () => controller.toggleFavoriteProduct(productId),
      ),
    );
  }
}
