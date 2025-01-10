import 'package:f_store_dashboard/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/data_table/table_header.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/all_categories/table/data_table.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CategoriesDesktopScreen extends StatelessWidget {
  const CategoriesDesktopScreen({super.key});

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
              /// BreadCrumbs
              const BreadcrumbWithHeading(
                  heading: 'Categories', breadcrumbItems: ['Categories']),
              const Gap(FSizes.spaceBtwItems),

              // Table Body
              // Show Loader
              FRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    FTableHeader(
                      buttonText: 'Create New Category',
                      onPressed: () => Get.toNamed(FRoutes.createCategory),
                    ),
                    const Gap(FSizes.spaceBtwItems),

                    // Table
                    const CategoriesTable(),
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
