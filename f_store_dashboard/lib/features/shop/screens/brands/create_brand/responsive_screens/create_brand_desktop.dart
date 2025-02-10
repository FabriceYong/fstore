import 'package:f_store_dashboard/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:f_store_dashboard/features/shop/controllers/brands_controller/create_brand_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/brands/create_brand/widgets/create_brand_form.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/loaders/normal_animated_loader.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CreateBrandDesktop extends StatelessWidget {
  const CreateBrandDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBrandController());
    return Scaffold(
      backgroundColor: FHelperFunctions.isDarkMode(context)
          ? Colors.black
          : FColors.primaryBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const BreadcrumbWithHeading(
                  returnToPrevScreen: true,
                  heading: 'Create Brand',
                  breadcrumbItems: [FRoutes.editBrand, 'Create Brand']),
              const Gap(FSizes.spaceBtwSections),

              /// Create Brand Form
              Obx(() {
                if (controller.isLoading.value) return const FLoaderAnimation();
                return const CreateBrandForm();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
