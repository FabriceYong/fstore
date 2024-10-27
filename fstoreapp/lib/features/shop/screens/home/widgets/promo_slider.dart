import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:fstoreapp/common/widgets/images/rounded_image.dart';
import 'package:fstoreapp/features/shop/controllers/home_controller.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FPromoSlider extends StatelessWidget {
  const FPromoSlider({super.key, required this.banners});

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                controller.carouselCurrentIndex.value = index;
              },
            ),
            items: banners
                .map((banner) => FRoundedImage(
                      imageUrl: banner,
                    ))
                .toList()),
        const Gap(FSizes.spaceBtwItems),
        Obx(
          () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < banners.length; i++)
                FCircularContainer(
                  width: 18,
                  height: 4,
                  backgroundColor: controller.carouselCurrentIndex.value == i
                      ? FColors.primary
                      : FColors.grey,
                  margin: const EdgeInsets.only(right: 10),
                )
            ],
          ),
        )
      ],
    );
  }
}
