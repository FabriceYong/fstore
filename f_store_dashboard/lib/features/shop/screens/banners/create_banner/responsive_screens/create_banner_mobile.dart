import 'package:f_store_dashboard/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:f_store_dashboard/features/shop/screens/banners/create_banner/widgets/create_banner_form.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreateBannerMobile extends StatelessWidget {
  const CreateBannerMobile({super.key});

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
              BreadcrumbWithHeading(
                  returnToPrevScreen: true,
                  heading: 'Create Banner',
                  breadcrumbItems: [FRoutes.createBanner, 'Create Banner']),
              Gap(FSizes.spaceBtwItems),

              // Form
              CreateBannerForm()
            ],
          ),
        ),
      ),
    );
  }
}