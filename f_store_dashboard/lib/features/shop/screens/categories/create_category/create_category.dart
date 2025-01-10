import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/create_category/responsive_screens/create_category_desktop.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/create_category/responsive_screens/create_category_mobile.dart';
import 'package:f_store_dashboard/features/shop/screens/categories/create_category/responsive_screens/create_category_tablet.dart';
import 'package:flutter/material.dart';

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FSiteTemplate(
      desktop: CreateCategoryDesktop(),
      tablet: CreateCategoryTablet(),
      mobile: CreateCategoryMobile(),
    );
  }
}
