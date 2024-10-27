import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/common/widgets/images/circular_image.dart';
import 'package:fstoreapp/common/widgets/schimmers/shimmer_effect.dart';
import 'package:fstoreapp/common/widgets/text/section_heading.dart';
import 'package:fstoreapp/features/personalization/controllers/re_authenticate_user_controller/re_authenticate_user_controller.dart';
import 'package:fstoreapp/features/personalization/controllers/user_controller/user_controller.dart';
import 'package:fstoreapp/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:fstoreapp/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:fstoreapp/features/personalization/screens/profile/widgets/update_username.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final reAuthController = Get.put(ReAuthenticateUserController());
    return Scaffold(
      appBar: const FAppBar(
        title: Text('Profile'),
        showBackArrow: true,
      ),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(
                      () => controller.profileLoading.value
                          ? const FShimmerEffect(
                              width: 80,
                              height: 80,
                              radius: 100,
                            )
                          : controller.imageUploading.value
                              ? const FShimmerEffect(
                                  width: 80,
                                  height: 80,
                                  radius: 100,
                                )
                              : FCircularImage(
                                  fit: BoxFit.cover,
                                  isNetworkImage: controller
                                      .user.value.profilePicture.isNotEmpty,
                                  image: controller
                                          .user.value.profilePicture.isNotEmpty
                                      ? controller.user.value.profilePicture
                                      : FImages.user,
                                  width: 80,
                                  height: 80,
                                ),
                    ),
                    TextButton(
                        onPressed: () => controller.uploadUserProfilePicture(),
                        child: const Text('Change Profile Picture')),
                  ],
                ),
              ),

              /// Details
              const Gap(FSizes.spaceBtwItems / 2),
              const Divider(),
              const Gap(FSizes.spaceBtwItems),
              const FSectionHeading(
                title: 'Profile Information',
                showActionButton: false,
              ),
              const Gap(FSizes.spaceBtwItems),

              Obx(
                () => controller.profileLoading.value
                    ? const FShimmerEffect(width: 200, height: 15)
                    : FProfileMenu(
                        onPressed: () => Get.to(() => const ChangeName()),
                        title: 'Name',
                        value: controller.user.value.fullName),
              ),
              Obx(
                () => controller.profileLoading.value
                    ? const FShimmerEffect(width: 200, height: 15)
                    : FProfileMenu(
                        onPressed: () => Get.to(() => const UpdateUsername()),
                        title: 'User Name',
                        value: controller.user.value.userName),
              ),

              const Gap(FSizes.spaceBtwItems / 2),
              const Divider(),
              const Gap(FSizes.spaceBtwItems / 2),

              /// Heading Personal information
              const FSectionHeading(
                title: 'Personal Information',
                showActionButton: false,
              ),
              const Gap(FSizes.spaceBtwItems / 2),

              Obx(
                () => controller.profileLoading.value
                    ? const FShimmerEffect(
                        height: 15,
                        width: 200,
                      )
                    : FProfileMenu(
                        title: 'User ID',
                        value: controller.user.value.id,
                        icon: Iconsax.copy,
                        onPressed: () {}),
              ),
              Obx(
                () => controller.profileLoading.value
                    ? const FShimmerEffect(
                        height: 15,
                        width: 200,
                      )
                    : FProfileMenu(
                        onPressed: () {},
                        title: 'E-Mail',
                        value: controller.user.value.email),
              ),
              Obx(
                () => controller.profileLoading.value
                    ? const FShimmerEffect(
                        height: 15,
                        width: 200,
                      )
                    : FProfileMenu(
                        onPressed: () {},
                        title: 'Phone Number',
                        value: controller.user.value.phoneNumber),
              ),
              FProfileMenu(onPressed: () {}, title: 'Gender', value: 'Male'),
              FProfileMenu(
                  onPressed: () {},
                  title: 'Date of Birth',
                  value: '10 Oct, 1998'),

              const Divider(),
              const Gap(FSizes.spaceBtwItems / 2),

              Center(
                child: TextButton(
                  onPressed: () => reAuthController.deleteAccountWarningPopup(),
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
