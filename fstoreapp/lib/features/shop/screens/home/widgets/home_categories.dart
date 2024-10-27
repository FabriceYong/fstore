import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:fstoreapp/features/shop/screens/sub_categories/sub_categories.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FHomeCategories extends StatelessWidget {
  const FHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        separatorBuilder: (_, __) => const Gap(FSizes.sm),
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return FVerticalImageText(
            image: FImages.shoeIcon,
            title: 'Shoes Category',
            onPressed: () => Get.to(() => const SubCategoriesScreen()),
          );
        },
      ),
    );
  }
}
