import 'package:f_store_dashboard/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:f_store_dashboard/features/shop/models/banner_model/banner_model.dart';
import 'package:f_store_dashboard/features/shop/screens/banners/edit_banner/widgets/edit_banner_form.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditBannerTablet extends StatelessWidget {
  const EditBannerTablet({super.key, required this.banner});

  final BannerModel banner;

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
              const BreadcrumbWithHeading(
                  returnToPrevScreen: true,
                  heading: 'Update Banner',
                  breadcrumbItems: [FRoutes.editBanner, 'Update Banner']),
              const Gap(FSizes.spaceBtwItems),

              // Form
              EditBannerForm(banner: banner)
            ],
          ),
        ),
      ),
    );
  }
}
