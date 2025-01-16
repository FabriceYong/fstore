import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/screens/products/edit_product/responsive_screens/edit_product_desktop.dart';
import 'package:f_store_dashboard/features/shop/screens/products/edit_product/responsive_screens/edit_product_mobile.dart';
import 'package:f_store_dashboard/features/shop/screens/products/edit_product/responsive_screens/edit_product_tablet.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FSiteTemplate(
      desktop: EditProductDesktop(),
      tablet: EditProductTablet(),
      mobile: EditProductMobile(),
    );
  }
}
