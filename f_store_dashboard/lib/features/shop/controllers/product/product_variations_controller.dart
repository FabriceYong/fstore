import 'package:f_store_dashboard/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:f_store_dashboard/features/shop/models/product/product_variations_model.dart';
import 'package:f_store_dashboard/utils/dialogs/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductVariationsController extends GetxController {
  // Singleton Instance
  static ProductVariationsController get instance => Get.find();

  final isLoading = false.obs;
  RxList<ProductVariationsModel> productVariations =
      <ProductVariationsModel>[].obs;
  final attributesController = Get.put(ProductAttributesController());

  // --- Refactored Controller Lists ---
  // Use simple lists where index corresponds to productVariations index
  List<TextEditingController> stockControllers = [];
  List<TextEditingController> priceControllers = [];
  List<TextEditingController> salePriceControllers = [];
  List<TextEditingController> descriptionControllers = [];
  // --- End Refactored Controller Lists ---

  void initializeVariationControllers(List<ProductVariationsModel> variations) {
    // Clear existing controllers
    stockControllers.clear();
    priceControllers.clear();
    salePriceControllers.clear();
    descriptionControllers.clear();

    // Create controllers for each loaded variation and set initial values
    for (var variation in variations) {
      stockControllers.add(TextEditingController(text: variation.stock.toString()));
      priceControllers.add(TextEditingController(text: variation.price.toString()));
      salePriceControllers.add(TextEditingController(text: variation.salePrice.toString()));
      descriptionControllers.add(TextEditingController(text: variation.description ?? ''));
    }
    // Assign the variations to the observable list AFTER initializing controllers
    productVariations.assignAll(variations);
  }

    // Method to remove variations with a confirmation dialog
  void removeVariations(BuildContext context) {
    FDialogs.defaultDialog(
        context: context,
        title: 'Remove Variation;',
        onPositive: () {
          // productVariations.value = []; // resetAllValues handles this
          resetAllValues();
          Navigator.pop(context);
        });
  }

  generateVariationsConfirmation(BuildContext context) {
    FDialogs.defaultDialog(
        context: context,
        title: 'Remove Variations',
        positive: 'Generate',
        content:
            'Once the variations have been created, you cannot add more attributes, In order to add more variations, you have to delete any of the attributes',
        onPositive: () => generateVariationsFromAttributes());
  }

  // Method to generate variations from existing attributes
  generateVariationsFromAttributes() {
    // Close the previous popup
    Get.back();

    final List<ProductVariationsModel> variations = [];

    // Check if there are attributes
    if (attributesController.productAttributes.isNotEmpty) {
      // Get all combinations of attribute values e.g [[Green, Blue] [Small, Large]]
      final List<List<String>> attributeCombinations = getCombinations(
          attributesController.productAttributes
              .map((attr) => attr.values ?? <String>[])
              .toList());

      // Generate ProductVariationModel for each combination of attribute values
      for (var combination in attributeCombinations) {
        final Map<String, String> attributeValues = Map.fromIterables(
            attributesController.productAttributes
                .map((attr) => attr.name ?? ''),
            combination);

        // Create the variation model
        final ProductVariationsModel variation = ProductVariationsModel(
          id: UniqueKey().toString(), // Generate a unique ID locally
          attributeValues: attributeValues,
          // Initialize other fields with defaults if needed
          stock: 0,
          price: 0.0,
          salePrice: 0.0,
          description: '',
          image: '', // Changed from ''.obs to plain String
        );
        variations.add(variation);

        // --- Create and add controllers to the new lists ---
        stockControllers.add(TextEditingController(text: variation.stock.toString()));
        priceControllers.add(TextEditingController(text: variation.price.toString()));
        salePriceControllers.add(TextEditingController(text: variation.salePrice.toString()));
        descriptionControllers.add(TextEditingController(text: variation.description ?? ''));
        // --- End Controller Creation ---
      }
    }

    // Assign the generated variations to the productVariations List;
    // This should happen AFTER controllers are created if UI depends on sync
    productVariations.assignAll(variations);
  }

  List<List<String>> getCombinations(List<List<String>> lists) {
    // The result list that will store all combinations
    final List<List<String>> result = [];

    // Start combining attributes from the first one
    combine(lists, 0, <String>[], result);

    // Return the final List of combinations
    return result;
  }


  // Helper function to recursively combine attribute values
  void combine(List<List<String>> lists, int index, List<String> current, List<List<String>> result) {
    // If we have reached the end of the list, add the current combination to the result
    if(index == lists.length){
      result.add(List.from(current));
      return;
    }

    // Iterate over the values of the current attribute
    for(final item in lists[index]){
      // Create an updated list with the current value added
      final List<String> updated = List.from(current)..add(item);

      // Recursively combine with the next attribute
      combine(lists, index + 1, updated, result);
    }
  }

  void resetAllValues() {
    // Clear variations list
    productVariations.clear();

    // Dispose and clear controllers to prevent memory leaks
    for (var controller in stockControllers) { controller.dispose(); }
    for (var controller in priceControllers) { controller.dispose(); }
    for (var controller in salePriceControllers) { controller.dispose(); }
    for (var controller in descriptionControllers) { controller.dispose(); }

    stockControllers.clear();
    priceControllers.clear();
    salePriceControllers.clear();
    descriptionControllers.clear();
  }
}
