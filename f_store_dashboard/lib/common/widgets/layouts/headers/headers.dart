import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/common/widgets/schimmers/shimmer_effect.dart';
import 'package:f_store_dashboard/features/authentication/controllers/user_controller.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FHeader extends StatelessWidget implements PreferredSizeWidget {
  const FHeader({super.key, this.scaffoldKey});
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final controller = UserController.instance;
    return Container(
      decoration: BoxDecoration(
        color: dark ? Colors.black : Colors.white,
        border: Border(
            bottom: BorderSide(
                color: dark ? FColors.darkerGrey : FColors.grey, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: FSizes.md,
        vertical: FSizes.sm,
      ),
      child: AppBar(
        leading: !FDeviceUtils.isDesktopScreen(context)
            ? IconButton(
                onPressed: () {
                  scaffoldKey!.currentState!.openDrawer();
                },
                icon: Icon(
                  Iconsax.menu,
                  color: dark ? Colors.white : Colors.black,
                ))
            : null, // Only show the Menu icon when in Desktop mode

        title: FDeviceUtils.isDesktopScreen(context)
            ? SizedBox(
                width: 400,
                child: TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.search_normal),
                      hintText: 'Search anything...'),
                ),
              )
            : null, // Only show the Search field when in Desktop mode

        ///Actions
        actions: [
          // Search Icon in Mobile mode
          if (!FDeviceUtils.isDesktopScreen(context))
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Iconsax.search_normal,
                  color: dark ? Colors.white : Colors.black,
                )),

          //Notification icon
          IconButton(
            onPressed: () {},
            icon: Icon(
              Iconsax.notification,
              color: dark ? Colors.white : Colors.black,
            ),
          ),
          const Gap(FSizes.spaceBtwItems / 2),

          // User info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => controller.loading.value
                    ? const FShimmerEffect(
                        width: 40,
                        height: 40,
                        radius: 50,
                      )
                    : FRoundedImage(
                        imageType:
                            controller.user.value.profilePicture.isNotEmpty
                                ? ImageType.asset
                                : ImageType.asset,
                        imageUrl:
                            controller.user.value.profilePicture.isNotEmpty
                                ? controller.user.value.profilePicture
                                : FImages.user,
                        height: 40,
                        width: 40,
                        padding: 2,
                      ),
              ),
              const Gap(FSizes.sm),

              // Name and Email
              if (!FDeviceUtils.isMobileScreen(context))
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      controller.loading.value
                          ? const FShimmerEffect(width: 70, height: 13)
                          : Text(
                              controller.user.value.fullName,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                      const Gap(FSizes.xs),
                      controller.loading.value
                          ? const FShimmerEffect(width: 50, height: 13)
                          : Text(
                              controller.user.value.email,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                    ],
                  ),
                )
            ],
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(FDeviceUtils.getAppBarHeight() + 15);
}
