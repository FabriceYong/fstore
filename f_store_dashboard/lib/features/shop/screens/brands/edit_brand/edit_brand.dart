import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/screens/brands/edit_brand/resposive_screens/edit_brand_desktop.dart';
import 'package:f_store_dashboard/features/shop/screens/brands/edit_brand/resposive_screens/edit_brand_mobile.dart';
import 'package:f_store_dashboard/features/shop/screens/brands/edit_brand/resposive_screens/edit_brand_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBrandScreen extends StatelessWidget {
  const EditBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = Get.arguments;
    return  FSiteTemplate(
      desktop: EditBrandDesktop(brand: brand),
      tablet: EditBrandTablet(brand: brand),
      mobile: EditBrandMobile(brand: brand),
    );
  }
}
