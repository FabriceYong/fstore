import 'package:f_store_dashboard/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:f_store_dashboard/features/shop/models/brand_model/brand_model.dart';
import 'package:f_store_dashboard/features/shop/screens/brands/edit_brand/widgets/edit_brand_form.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditBrandTablet extends StatelessWidget {
  const EditBrandTablet({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? Colors.black : FColors.light,
      body:  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              BreadcrumbWithHeading(
                  returnToPrevScreen: true,
                  heading: 'Update Brand',
                  breadcrumbItems: [FRoutes.editBrand, 'Update Brand']),
              Gap(FSizes.spaceBtwSections),

              /// Create Brand Form
              EditBrandForm(brand: brand,)
            ],
          ),
        ),
      ),
    );
  }
}
