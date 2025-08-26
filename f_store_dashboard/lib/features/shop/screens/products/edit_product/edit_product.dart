import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/edit_product_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/products/edit_product/responsive_screens/edit_product_desktop.dart';
import 'package:f_store_dashboard/features/shop/screens/products/edit_product/responsive_screens/edit_product_mobile.dart';
import 'package:f_store_dashboard/features/shop/screens/products/edit_product/responsive_screens/edit_product_tablet.dart';
import 'package:f_store_dashboard/features/shop/models/product/product_model.dart'; // Import ProductModel
import 'package:f_store_dashboard/utils/popups/snackbars.dart'; // Import Snackbars
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Safely get arguments and check for null
    final product = Get.arguments;
    if (product == null || product is! ProductModel) {
      // Handle the case where arguments are missing or not a ProductModel
      // You might want to navigate back or show an error message
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.back();
        Snackbars.errorSnackBar(title: 'Error', message: 'Product data not found. Navigating back.');
      });
      // Return an empty container or a loading indicator while navigating back
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // If product is valid, proceed to put the controller and build the UI
    final controller = Get.put(EditProductController());
    return FSiteTemplate(
      desktop: EditProductDesktop(
        product: product, // Now we know product is a valid ProductModel
      ),
      tablet: const EditProductTablet(), // Consider passing product here too if needed
      mobile: EditProductMobile(product: product), // Now we know product is a valid ProductModel
    );
  }
}
