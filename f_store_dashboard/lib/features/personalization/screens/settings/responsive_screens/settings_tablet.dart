import 'package:f_store_dashboard/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:f_store_dashboard/features/personalization/controllers/settngs_controller/settings_controller.dart';
import 'package:f_store_dashboard/features/personalization/screens/settings/widgets/image_and_meta_data.dart';
import 'package:f_store_dashboard/features/personalization/screens/settings/widgets/settings_form.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/loaders/normal_animated_loader.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SettingsTabletScreen extends StatelessWidget {
  const SettingsTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());
    return Scaffold(
      backgroundColor: FHelperFunctions.isDarkMode(context)
          ? Colors.black
          : FColors.primaryBackground,
      body: Padding(
        padding: const EdgeInsets.all(FSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const BreadcrumbWithHeading(
                  heading: 'App Settings', breadcrumbItems: ['Settings']),
              const Gap(FSizes.spaceBtwSections),

              // Body
              Column(
                children: [
                  // Settings Picture and Meta Data
                  const ImageAndMetaData(),
                  const Gap(FSizes.spaceBtwSections),

                  // Form
                  Obx(() {
                    if (controller.loading.value) {
                      return const FLoaderAnimation();
                    }
                    return const SettingsForm();
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
