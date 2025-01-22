import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/models/product_model/product_model.dart';
import 'package:f_store_dashboard/features/shop/screens/products/edit_product/responsive_screens/edit_product_desktop.dart';
import 'package:f_store_dashboard/features/shop/screens/products/edit_product/responsive_screens/edit_product_mobile.dart';
import 'package:f_store_dashboard/features/shop/screens/products/edit_product/responsive_screens/edit_product_tablet.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductModel(
        id: 'id',
        title: 'title',
        category: 'category',
        description: 'description');
    return FSiteTemplate(
      desktop: EditProductDesktop(
        product: product,
      ),
      tablet: const EditProductTablet(),
      mobile: EditProductMobile(product: product),
    );
  }
}
