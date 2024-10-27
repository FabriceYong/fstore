import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:fstoreapp/common/widgets/text/section_heading.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';

class UploadData extends StatelessWidget {
  const UploadData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FAppBar(title: Text('Upload Data'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
          child: Column(
            children: [
              /// Header
              const FSectionHeading(
                title: 'Main Record',
                showActionButton: false,
              ),
              const Gap(FSizes.spaceBtwItems / 2),

              const Column(
                children: [
                  FSettingsMenuTile(
                    icon: Iconsax.menu,
                    title: 'Upload Categories',
                    trailing: Icon(
                      Icons.arrow_circle_up,
                      color: FColors.primary,
                    ),
                  ),
                  FSettingsMenuTile(
                    icon: Iconsax.shop,
                    title: 'Upload Brands',
                    trailing: Icon(
                      Icons.arrow_circle_up,
                      color: FColors.primary,
                    ),
                  ),
                  FSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'Upload Products',
                    trailing: Icon(
                      Icons.arrow_circle_up,
                      color: FColors.primary,
                    ),
                  ),
                  FSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'Upload Banners',
                    trailing: Icon(
                      Icons.arrow_circle_up,
                      color: FColors.primary,
                    ),
                  )
                ],
              ),
              const Gap(FSizes.defaultSpace),
              const FSectionHeading(
                title: 'Relationships',
                showActionButton: false,
              ),
              Text(
                'Make sure you have already uploaded all the content above',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const Column(
                children: [
                  FSettingsMenuTile(
                    icon: Iconsax.link,
                    title: 'Upload Brands & Categories Relational Data',
                    trailing: Icon(
                      Icons.arrow_circle_up,
                      color: FColors.primary,
                    ),
                  ),
                  FSettingsMenuTile(
                    icon: Iconsax.link,
                    title: 'Upload Products & Categories Relational Data',
                    trailing: Icon(
                      Icons.arrow_circle_up,
                      color: FColors.primary,
                    ),
                  ),
                  FSettingsMenuTile(
                    icon: Iconsax.link,
                    title: 'Upload Products & Brands Relational Data',
                    trailing: Icon(
                      Icons.arrow_circle_up,
                      color: FColors.primary,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
