import 'package:f_store_dashboard/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/data_table/table_header.dart';
import 'package:f_store_dashboard/features/shop/screens/brands/all_brands/table/table_data.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BrandsDesktopScreen extends StatelessWidget {
  const BrandsDesktopScreen({super.key});

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
                  heading: 'Brands', breadcrumbItems: ['Brands']),
              const Gap(FSizes.spaceBtwSections),

              FRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    FTableHeader(
                      buttonText: 'Create New Category',
                      onPressed: () => Get.toNamed(FRoutes.createBrand),
                    ),
                    const Gap(FSizes.spaceBtwItems),

                    // Brands Table
                    const BrandsTable(),
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