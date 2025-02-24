import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/screens/products/create_product/responsive_screens/create_product_desktop.dart';
import 'package:f_store_dashboard/features/shop/screens/products/create_product/responsive_screens/create_product_mobile.dart';
import 'package:flutter/material.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FSiteTemplate(
      desktop: CreateProductDesktop(),
      mobile: CreateProductMobile(),
    );
  }
}
