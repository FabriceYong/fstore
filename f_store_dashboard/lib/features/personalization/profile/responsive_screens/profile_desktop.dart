import 'package:f_store_dashboard/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:f_store_dashboard/features/personalization/profile/widgets/image_and_meta_data.dart';
import 'package:f_store_dashboard/features/personalization/profile/widgets/profile_form.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileDesktopScreen extends StatelessWidget {
  const ProfileDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FHelperFunctions.isDarkMode(context)
          ? Colors.black
          : FColors.primaryBackground,
      body: const Padding(
        padding: EdgeInsets.all(FSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              BreadcrumbWithHeading(
                  heading: 'Profile', breadcrumbItems: ['Profile']),
              Gap(FSizes.spaceBtwSections),

              // Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Picture and Meta Data
                  Expanded(child: ImageAndMetaData()),
                  Gap(FSizes.spaceBtwSections),

                  // Form
                  Expanded(
                    flex: 2,
                    child: ProfileForm(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
