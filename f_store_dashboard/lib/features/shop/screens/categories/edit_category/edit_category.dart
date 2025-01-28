import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/edit_category/responsive_screens/edit_category_deskktop.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/edit_category/responsive_screens/edit_category_mobile.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/edit_category/responsive_screens/edit_category_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Get.arguments;
    return FSiteTemplate(
      desktop: EditCategoryDesktop(category: category),
      tablet: EditCategoryTablet(category: category),
      mobile: EditCategoryMobile(category: category),
    );
  }
}
