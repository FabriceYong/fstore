import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/common/widgets/images/rounded_image.dart';
import 'package:fstoreapp/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:fstoreapp/common/widgets/text/section_heading.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FAppBar(
        title: Text('Sub Categories'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
          child: Column(
            children: [
              /// Banner
              const FRoundedImage(
                imageUrl: FImages.promoBanner1,
                width: double.infinity,
              ),
              const Gap(FSizes.spaceBtwItems),

              /// Sub_Categories
              Column(
                children: [
                  const FSectionHeading(
                    title: 'Sports Shirts',
                    showActionButton: true,
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      separatorBuilder: (_, __) => const Gap(FSizes.sm),
                      itemBuilder: (context, index) =>
                          const FProductCardHorizontal(),
                    ),
                  ),
                  const FSectionHeading(
                    title: 'Sports Shirts',
                    showActionButton: true,
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      separatorBuilder: (_, __) => const Gap(FSizes.sm),
                      itemBuilder: (context, index) =>
                          const FProductCardHorizontal(),
                    ),
                  ),
                  const FSectionHeading(
                    title: 'Sports Shirts',
                    showActionButton: true,
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      separatorBuilder: (_, __) => const Gap(FSizes.sm),
                      itemBuilder: (context, index) =>
                          const FProductCardHorizontal(),
                    ),
                  ),
                  const FSectionHeading(
                    title: 'Sports Shirts',
                    showActionButton: true,
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      separatorBuilder: (_, __) => const Gap(FSizes.sm),
                      itemBuilder: (context, index) =>
                          const FProductCardHorizontal(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
