import 'package:f_store_dashboard/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:f_store_dashboard/features/shop/models/category_model/category_model.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/edit_category/widgets/edit_category_form.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditCategoryMobile extends StatelessWidget {
  const EditCategoryMobile({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? Colors.black : FColors.light,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Breadcrumbs
              const BreadcrumbWithHeading(
                  returnToPrevScreen: true,
                  heading: 'Update Category',
                  breadcrumbItems: [FRoutes.editCategory, 'Update Category']),
              const Gap(FSizes.spaceBtwSections),

              EditCategoryForm(category: category)
            ],
          ),
        ),
      ),
    );
  }
}
