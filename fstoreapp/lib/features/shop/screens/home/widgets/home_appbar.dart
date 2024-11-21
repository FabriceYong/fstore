import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/common/widgets/images/rounded_image.dart';
import 'package:fstoreapp/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:fstoreapp/common/widgets/schimmers/shimmer_effect.dart';
import 'package:fstoreapp/features/personalization/controllers/user_controller/user_controller.dart';
import 'package:fstoreapp/features/shop/screens/cart/cart.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/constants/text_strings.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FHomeAppBar extends StatelessWidget {
  const FHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return FAppBar(
      showBackArrow: false,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => controller.profileLoading.value
                ? const FShimmerEffect(
                    width: 40,
                    height: 40,
                    radius: 100,
                  )
                : FRoundedImage(
                    width: 40,
                    height: 40,
                    borderRadius: 100,
                    applyImageRadius: true,
                    isNetworkImage:
                        controller.user.value.profilePicture.isNotEmpty,
                    imageUrl: controller.user.value.profilePicture.isNotEmpty
                        ? controller.user.value.profilePicture
                        : FImages.user),
          ),
          const Gap(FSizes.sm),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              FTexts.homeAppbarTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: FColors.grey),
            ),
            Obx(
              () => controller.profileLoading.value
                  ? const FShimmerEffect(width: 150, height: 16)
                  : Text(
                      controller.user.value.fullName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .apply(color: FColors.white),
                    ),
            ),
          ])
        ],
      ),
      actions: [
        FCartCounterIcon(
          iconColor: FColors.white,
        )
      ],
    );
  }
}
