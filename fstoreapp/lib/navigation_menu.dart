import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fstoreapp/features/personalization/screens/settings/settings.dart';
import 'package:fstoreapp/features/shop/screens/home/home.dart';
import 'package:fstoreapp/features/shop/screens/store/store_screen.dart';
import 'package:fstoreapp/features/shop/screens/wishlist/wishlist.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
        bottomNavigationBar: Obx(
          () => NavigationBar(
              height: 70,
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? FColors.dark.withOpacity(.1)
                  : FColors.white.withOpacity(.1),
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Iconsax.home),
                  label: 'Home',
                  selectedIcon: Icon(Iconsax.home5),
                ),
                NavigationDestination(
                  icon: Icon(Iconsax.shop),
                  label: 'Store',
                  selectedIcon: Icon(Iconsax.shop5),
                ),
                NavigationDestination(
                  icon: Icon(Iconsax.heart),
                  label: 'Wishlist',
                  selectedIcon: Icon(Iconsax.heart5),
                ),
                NavigationDestination(
                  icon: Icon(Iconsax.user),
                  label: 'Profile',
                  selectedIcon: Icon(CupertinoIcons.person_fill),
                ),
              ]),
        ),
        body: Obx(() => controller.screens[controller.selectedIndex.value]));
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final List<Widget> screens = [
    const HomeScreen(),
    const StoreScreen(),
    const WishlistScreen(),
    const SettingsScreen(),
  ];
}
