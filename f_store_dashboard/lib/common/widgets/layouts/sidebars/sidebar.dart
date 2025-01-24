import 'package:f_store_dashboard/common/widgets/images/circular_image.dart';
import 'package:f_store_dashboard/common/widgets/layouts/sidebars/menu/menu_item.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class FSidebar extends StatelessWidget {
  const FSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: BoxDecoration(
          color: dark ? Colors.black : Colors.white,
          border: Border(
            right: BorderSide(
                color: dark ? FColors.darkerGrey : FColors.grey, width: 1),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Image
              FCircularImage(
                image: dark ? FImages.lightAppLogo : FImages.darkAppLogo,
                backgroundColor: Colors.transparent,
                width: 100,
                height: 100,
              ),
              const Gap(FSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.all(FSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'MENU',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(letterSpacingDelta: 1.2),
                    ),

                    const Gap(FSizes.spaceBtwItems),
                    // Menu Items
                    const FMenuItem(
                      itemName: 'Dashboard',
                      icon: Iconsax.status,
                      route: FRoutes.dashboard,
                    ),
                    const FMenuItem(
                      itemName: 'Media',
                      icon: Iconsax.image,
                      route: FRoutes.media,
                    ),
                    const FMenuItem(
                      itemName: 'Categories',
                      icon: Iconsax.category_2,
                      route: FRoutes.categories,
                    ),
                    const FMenuItem(
                        route: FRoutes.brands,
                        icon: Iconsax.dcube,
                        itemName: 'Brands'),
                    const FMenuItem(
                        route: FRoutes.banners,
                        icon: Iconsax.picture_frame,
                        itemName: 'Banners'),
                    const FMenuItem(
                        route: FRoutes.products,
                        icon: Iconsax.shopping_bag,
                        itemName: 'Products'),
                    const FMenuItem(
                        route: FRoutes.customers,
                        icon: Iconsax.user,
                        itemName: 'Customers'),
                    const FMenuItem(
                        route: FRoutes.orders,
                        icon: Iconsax.box,
                        itemName: 'Orders'),

                    /// Other Menu Items
                    Text(
                      'OTHER',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(letterSpacingDelta: 1.2),
                    ),
                    const FMenuItem(
                      route: FRoutes.profile,
                      icon: Iconsax.user,
                      itemName: 'Profile',
                    ),
                    const FMenuItem(
                        route: FRoutes.settings,
                        icon: Iconsax.setting,
                        itemName: 'Settings'),
                    const FMenuItem(
                      route: 'logout',
                      icon: Iconsax.logout,
                      itemName: 'Logout',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
