import 'package:fstoreapp/features/shop/controllers/product/images_controller.dart';
import 'package:fstoreapp/features/shop/models/product_variations_model.dart';
import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  /// Variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationsModel> selectedVariation =
      ProductVariationsModel.empty().obs;

  /// -- Select Attribute, and Variation
  void onAttributeSelected(
      ProductModel product, attributeName, attributeValue) {
    // When attribute is selected, we will first add that attribute to the selectedAttributes array
    final selectedAttributes =
        Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariations!.firstWhere(
        (variation) =>
            _isSameAttribute(variation.attributes, selectedAttributes),
        orElse: () => ProductVariationsModel.empty());

    if (selectedVariation.image.isNotEmpty) {
      ImagesController.instance.selectedProductImage.value =
          selectedVariation.image;
    }

    // Assign Selected Variation
    this.selectedVariation.value = selectedVariation;

    // Update selected product variation status
    getProductVariationStockStatus();
  }

  /// -- Check if selected attributes matches any variation attributes
  bool _isSameAttribute(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> selectedAttributes) {
    // If selectedAttributes contains 3 attributes and current variation contains 2 then return
    if (variationAttributes.length != selectedAttributes.length) return false;

    // if any of the attributes is different then return. e.g [Green, Large] x [Green, Small]
    for (final key in variationAttributes.keys) {
      // Attribute[key] = Value which could be [Green, Small, Cotton etc] etc
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }
    return true;
  }

  /// -- Check Attribute Availability / Stock in Variation
  Set<String> getAttributesAvailabilityInVariation(
      List<ProductVariationsModel> variations, String attributeName) {
    // Pass the variation to check which attribute are available and stock is not 0
    final availableVariationAttributes = variations
        .where((variation) =>
            // Check empty / Out of Stock Attributes
            variation.attributes[attributeName] != null &&
            variation.attributes[attributeName]!.isNotEmpty &&
            variation.stock > 0)
        .map((variation) => variation.attributes[attributeName].toString())
        .toSet();
    return availableVariationAttributes;
  }

  /// Get Variation Price
  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toString();
  }

  /// -- Check Product Variation Stock Status
  void getProductVariationStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  /// -- Reset Selected Attributes when switching products
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationsModel.empty();
  }
}
