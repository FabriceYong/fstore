
import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/common/widgets/appbar/tabbar.dart';
import 'package:fstoreapp/common/widgets/brands/brand_card.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:fstoreapp/common/widgets/layouts/grid-layout.dart';
import 'package:fstoreapp/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:fstoreapp/common/widgets/text/section_heading.dart';
import 'package:fstoreapp/features/shop/screens/brands/all_brands.dart';
import 'package:fstoreapp/features/shop/screens/store/widgets/category_tab.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: FAppBar(
          showBackArrow: false,
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [FCartCounterIcon(onPressed: () {})],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.black
                    : FColors.white,
                expandedHeight: 415,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// -- Search Bar
                      const Gap(FSizes.spaceBtwItems),
                      const FSearchContainer(
                        padding: EdgeInsets.zero,
                        icon: Iconsax.search_normal,
                        text: 'Search in Store',
                        showBorder: true,
                      ),
                      const Gap(FSizes.spaceBtwItems / 2),

                      /// -- Featured Brands
                      FSectionHeading(
                          title: 'Featured Brands',
                          onPressed: () =>
                              Get.to(() => const AllBrandsScreen()),
                          showActionButton: true),
                      const Gap(FSizes.spaceBtwItems / 2),

                      /// Brands
                      FGridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (context, index) {
                          return FBrandCard(
                            showBorder: true,
                            onTap: () {},
                          );
                        },
                      )
                    ],
                  ),
                ),
                bottom: const FTabBar(tabs: [
                  Tab(child: Text('Sports')),
                  Tab(child: Text('Furniture')),
                  Tab(child: Text('Electronics')),
                  Tab(child: Text('Clothes')),
                  Tab(child: Text('Cosmetics')),
                ]),
              )
            ];
          },
          body: const TabBarView(
            children: [
              FCategoryTab(),
              FCategoryTab(),
              FCategoryTab(),
              FCategoryTab(),
              FCategoryTab(),
            ],
          ),
        ),
      ),
    );
  }
}
