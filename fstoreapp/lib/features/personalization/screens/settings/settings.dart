import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:fstoreapp/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:fstoreapp/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:fstoreapp/common/widgets/text/section_heading.dart';
import 'package:fstoreapp/data/repositories/authentication/authentication_repository.dart';
import 'package:fstoreapp/features/personalization/screens/addresses/addresses.dart';
import 'package:fstoreapp/features/personalization/screens/upload_data/upload_data.dart';
import 'package:fstoreapp/features/shop/screens/cart/cart.dart';
import 'package:fstoreapp/features/shop/screens/orders/orders.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Header
            const FPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// AppBar
                  FAppBar(
                    showBackArrow: false,
                    title: Text('Account'),
                  ),
                  Gap(FSizes.spaceBtwItems),

                  /// User Profile Card
                  FUserProfileTile(),
                  Gap(FSizes.spaceBtwSections)
                ],
              ),
            ),

            /// -- Body
            Padding(
              padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
              child: Column(
                children: [
                  /// -- Account Settings
                  const FSectionHeading(
                    title: 'Account Settings',
                    showActionButton: true,
                  ),
                  const Gap(FSizes.spaceBtwItems / 2),

                  FSettingsMenuTile(
                      icon: Iconsax.safe_home,
                      title: 'My Addresses',
                      subTitle: 'Set shopping delivery address',
                      onTap: () => Get.to(() => const UserAddressScreen())),

                  FSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subTitle: 'Add, remove products and move to checkout',
                    onTap: () => Get.to(() => const CartScreen()),
                  ),
                  FSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subTitle: 'In-Progress and completed Orders',
                    onTap: () => Get.to(() => const OrdersScreen()),
                  ),
                  const FSettingsMenuTile(
                      icon: Iconsax.bank,
                      title: 'Bank Account',
                      subTitle: 'Withdraw balance to registered bank account'),
                  const FSettingsMenuTile(
                      icon: Iconsax.discount_shape,
                      title: 'My Coupons',
                      subTitle: 'List of all the discounted coupons'),
                  const FSettingsMenuTile(
                      icon: Iconsax.notification,
                      title: 'Notifications',
                      subTitle: 'Set any kind of notification messages'),
                  const FSettingsMenuTile(
                      icon: Iconsax.security_card,
                      title: 'Account Privacy',
                      subTitle: 'Manage data usage and connected accounts'),

                  /// -- App Settings
                  const Gap(FSizes.spaceBtwItems),
                  const FSectionHeading(
                      title: 'App Settings', showActionButton: true),
                  // const Gap(FSizes.spaceBtwItems / 2),
                  FSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Load Data',
                    subTitle: 'Upload Data to your Cloud Firebase',
                    onTap: () => Get.to(() => const UploadData()),
                  ),

                  FSettingsMenuTile(
                      icon: Iconsax.location,
                      title: 'Geolocation',
                      subTitle: 'Set recommendation based on location',
                      trailing: Switch(value: false, onChanged: (value) {})),
                  FSettingsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Safe Mode',
                      subTitle: 'Search results is safe for all pages',
                      trailing: Switch(value: true, onChanged: (value) {})),
                  FSettingsMenuTile(
                      icon: Iconsax.image,
                      title: 'HD Image Quality',
                      subTitle: 'Set image quality to be seen',
                      trailing: Switch(value: false, onChanged: (value) {})),
                  const Gap(FSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          icon: const Icon(
                            Icons.warning,
                            color: Colors.amber,
                            size: 28,
                          ),
                          title: Text(
                            'Logout',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          content: Text(
                            'Are you sure you want to logout?',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          actionsAlignment: MainAxisAlignment.spaceBetween,
                          actions: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  OutlinedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Cancel'),
                                  ),
                                  const Gap(FSizes.spaceBtwItems),
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            side: const BorderSide(
                                                color: Colors.red)),
                                        onPressed: () =>
                                            AuthenticationRepository.instance
                                                .logout(),
                                        child: const Text('Logout')),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      child: const Text('Logout'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
