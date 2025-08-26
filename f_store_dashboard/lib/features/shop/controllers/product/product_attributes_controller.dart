import 'package:f_store_dashboard/features/shop/controllers/product/product_variations_controller.dart';
import 'package:f_store_dashboard/features/shop/models/product/product_attributes_model.dart';
import 'package:f_store_dashboard/utils/dialogs/dialog.dart';
import 'package:f_store_dashboard/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductAttributesController extends GetxController{
  static ProductAttributesController get instance => Get.find();

  final isLoading = false.obs;
  final attributesFormKey = GlobalKey<FormState>();
  TextEditingController attributeName = TextEditingController();
  TextEditingController attributes = TextEditingController();
  RxList<ProductAttributesModel> productAttributes = <ProductAttributesModel>[].obs;

  void addNewAttribute() {
    try{
      if(!attributesFormKey.currentState!.validate()) {
        return;
      }

      // Add attributes to the List of Attributes
      productAttributes.add(ProductAttributesModel(name: attributeName.text.trim(), values: attributes.text.trim().split('|').toList()));

      // Clear Text Fields after adding
      attributeName.text = '';
      attributes.text = '';
    }catch(e){
    Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }

  // Remove attribute
  void removeAttribute(int index, BuildContext context) {
    FDialogs.defaultDialog(context: context, onPositive: () {
      // User Confirmed, Remove the attribute
      Navigator.pop(context);
      productAttributes.removeAt(index);

      ProductVariationsController.instance.productVariations.value = [];
    
    } );
  }

  void resetProductAttributes(){
    productAttributes.clear();
  }
}