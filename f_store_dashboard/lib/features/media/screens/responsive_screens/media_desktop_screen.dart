import 'package:f_store_dashboard/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:f_store_dashboard/features/media/controllers/media_controller.dart';
import 'package:f_store_dashboard/features/media/screens/widgets/media_content.dart';
import 'package:f_store_dashboard/features/media/screens/widgets/media_uploader.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MediaDesktopScreen extends StatelessWidget {
  const MediaDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Scaffold(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? Colors.black : FColors.light,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Breadcrumbs
                  const BreadcrumbWithHeading(
                    heading: 'Media',
                    breadcrumbItems: [FRoutes.login, 'Media Screen'],
                  ),

                  // Upload Images Button
                  SizedBox(
                    width: FSizes.buttonWidth * 1.5,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(FSizes.sm)))),
                      onPressed: () => controller.showImagesUploaderSection
                          .value = !controller.showImagesUploaderSection.value,
                      label: const Text('Upload Images'),
                      icon: const Icon(Iconsax.cloud_add),
                    ),
                  ),
                ],
              ),
              const Gap(FSizes.spaceBtwSections),

              /// Upload Area
              const FMediaUploaderWidget(),
              const Gap(FSizes.spaceBtwSections),

              // Media
              const FMediaContentWidget()
            ],
          ),
        ),
      ),
    );
  }
}
