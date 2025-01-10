import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/screens/brands/create_brand/responsive_screens/create_brand_desktop.dart';
import 'package:f_store_dashboard/features/shop/screens/brands/create_brand/responsive_screens/create_brand_mobile.dart';
import 'package:f_store_dashboard/features/shop/screens/brands/create_brand/responsive_screens/create_brand_tablet.dart';
import 'package:flutter/material.dart';

class CreateBrandScreen extends StatelessWidget {
  const CreateBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FSiteTemplate(
      desktop: CreateBrandDesktop(),
      tablet: CreateBrandTablet(),
      mobile: CreateBrandMobile(),
    );
  }
}
