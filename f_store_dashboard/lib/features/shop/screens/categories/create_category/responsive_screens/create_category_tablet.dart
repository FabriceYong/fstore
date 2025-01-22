import 'package:f_store_dashboard/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/create_category/widgets/create_category_form.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreateCategoryTablet extends StatelessWidget {
  const CreateCategoryTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? Colors.black : FColors.primaryBackground,
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              BreadcrumbWithHeading(
                  returnToPrevScreen: true,
                  heading: 'Create Category',
                  breadcrumbItems: [FRoutes.createCategory, 'Create Category']),
              Gap(FSizes.spaceBtwSections),

              // Form
              CreateCategoryForm(),
            ],
          ),
        ),
      ),
    );
  }
}