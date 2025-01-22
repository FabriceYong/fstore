import 'package:f_store_dashboard/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:f_store_dashboard/features/shop/screens/brands/create_brand/widgets/create_brand_form.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreateBrandMobile extends StatelessWidget {
  const CreateBrandMobile({super.key});

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
                  heading: 'Create Brand',
                  breadcrumbItems: [FRoutes.createBrand, 'Create Brand']),
              Gap(FSizes.spaceBtwSections),

              /// Create Brand Form
              CreateBrandForm()
            ],
          ),
        ),
      ),
    );
  }
}