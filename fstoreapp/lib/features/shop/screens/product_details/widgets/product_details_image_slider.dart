import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:fstoreapp/common/widgets/icons/favourite_icon.dart';
import 'package:fstoreapp/common/widgets/images/rounded_image.dart';
import 'package:fstoreapp/features/shop/controllers/product/images_controller.dart';
import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FProductDetailsImageSlider extends StatelessWidget {
  const FProductDetailsImageSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);
    return FCurvedEdgesWidget(
        child: Container(
      color: FHelperFunctions.isDarkMode(context)
          ? FColors.darkerGrey
          : FColors.light,
      child: Stack(
        children: [
          /// Main Large Image
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(FSizes.productImageRadius * 2),
              child: Obx(
                () => Center(
                  child: InkWell(
                    onTap: () => controller.showEnlargedImage(
                        controller.selectedProductImage.value),
                    child: CachedNetworkImage(
                      imageUrl: controller.selectedProductImage.value,
                      progressIndicatorBuilder: (_, __, downloadProgress) =>
                          CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: FColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// AppBar Icons
           FAppBar(
            showBackArrow: true,
            actions: [
              FFavoriteIcon(productId: product.id,),
            ],
          ),

          /// Image Slider
          Positioned(
            right: 0,
            bottom: 30,
            left: FSizes.defaultSpace / 2,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: images.length,
                separatorBuilder: (_, __) =>
                    const Gap(FSizes.spaceBtwItems / 2),
                itemBuilder: (context, index) {
                  return Obx(() {
                    final imageSelected =
                        controller.selectedProductImage.value == images[index];
                    return FRoundedImage(
                      width: 80,
                      isNetworkImage: true,
                      imageUrl: images[index],
                      border: Border.all(
                          color: imageSelected
                              ? FColors.primary
                              : Colors.transparent),
                      padding: const EdgeInsets.all(FSizes.sm),
                      backgroundColor: FHelperFunctions.isDarkMode(context)
                          ? FColors.dark
                          : FColors.white,
                      onPressed: () =>
                          controller.selectedProductImage.value = images[index],
                    );
                  });
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
