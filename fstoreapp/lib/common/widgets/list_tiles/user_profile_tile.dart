import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/images/circular_image.dart';
import 'package:fstoreapp/common/widgets/schimmers/shimmer_effect.dart';
import 'package:fstoreapp/features/personalization/controllers/user_controller/user_controller.dart';
import 'package:fstoreapp/features/personalization/screens/profile/profile.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FUserProfileTile extends StatelessWidget {
  const FUserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return ListTile(
      leading: Obx(
        () => controller.profileLoading.value
            ? const FShimmerEffect(
                width: 50,
                height: 50,
                radius: 100,
              )
            : FCircularImage(
                isNetworkImage: controller.user.value.profilePicture != '',
                image: controller.user.value.profilePicture != ''
                    ? controller.user.value.profilePicture
                    : FImages.user,
                width: 50,
                height: 50,
                padding: 0,
              ),
      ),
      title: Obx(
        () => controller.profileLoading.value
            ? const FShimmerEffect(width: 150, height: 18)
            : Text(
                controller.user.value.fullName,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
      ),
      subtitle: Obx(
        () => controller.profileLoading.value
            ? const FShimmerEffect(width: 80, height: 12)
            : Text(
                controller.user.value.email,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: FColors.white),
              ),
      ),
      trailing: IconButton(
        onPressed: () => Get.to(() => const ProfileScreen()),
        icon: const Icon(Iconsax.edit),
        color: FColors.white,
      ),
    );
  }
}
