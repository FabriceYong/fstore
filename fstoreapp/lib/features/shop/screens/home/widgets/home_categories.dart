import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:fstoreapp/common/widgets/schimmers/category_shimmer.dart';
import 'package:fstoreapp/features/shop/controllers/category_controller.dart';
import 'package:fstoreapp/features/shop/screens/sub_categories/sub_categories.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FHomeCategories extends StatelessWidget {
  const FHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Obx(() {
      if (controller.isLoading.value) return const FCategoryShimmer();

      if (controller.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'No Data Found',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.white),
          ),
        );
      }
      return SizedBox(
        height: 80,
        child: ListView.separated(
          separatorBuilder: (_, __) => const Gap(FSizes.sm),
          itemCount: controller.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final category = controller.featuredCategories[index];
            return FVerticalImageText(
              backgroundColor: FHelperFunctions.isDarkMode(context)
                  ? FColors.dark
                  : FColors.light,
              image: category.image,
              title: category.name,
              onPressed: () => Get.to(() => const SubCategoriesScreen()),
            );
          },
        ),
      );
    });
  }
}
