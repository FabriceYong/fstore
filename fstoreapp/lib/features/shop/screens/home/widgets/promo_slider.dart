import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:fstoreapp/common/widgets/images/rounded_image.dart';
import 'package:fstoreapp/common/widgets/schimmers/shimmer_effect.dart';
import 'package:fstoreapp/features/shop/controllers/banner_controller.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FPromoSlider extends StatelessWidget {
  const FPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(
      () => controller.isLoading.value
          ? const FShimmerEffect(width: double.infinity, height: 190)
          : controller.banners.isEmpty
              ? const Center(
                  child: Text('No Data Found'),
                )
              : Column(
                  children: [
                    CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            controller.carouselCurrentIndex.value = index;
                          },
                        ),
                        items: controller.banners
                            .map((banner) => FRoundedImage(
                                  imageUrl: banner.imageUrl,
                                  isNetworkImage: true,
                                  onPressed: () =>
                                      Get.toNamed(banner.targetScreen),
                                ))
                            .toList()),
                    const Gap(FSizes.spaceBtwItems),
                    Obx(
                      () => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < controller.banners.length; i++)
                            FCircularContainer(
                              width: 18,
                              height: 4,
                              backgroundColor:
                                  controller.carouselCurrentIndex.value == i
                                      ? FColors.primary
                                      : FColors.grey,
                              margin: const EdgeInsets.only(right: 10),
                            )
                        ],
                      ),
                    )
                  ],
                ),
    );
  }
}
