import 'package:f_store_dashboard/data/repositories/product_repository/product_repository.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/product_controller.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/product_images_controller.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/product_variations_controller.dart';
import 'package:f_store_dashboard/features/shop/models/brand_model/brand_model.dart';
import 'package:f_store_dashboard/features/shop/models/category_model/category_model.dart';
import 'package:f_store_dashboard/features/shop/models/product/product_category_model.dart';
import 'package:f_store_dashboard/features/shop/models/product/product_model.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/network_manager.dart';
import 'package:f_store_dashboard/utils/loaders/full_screen_loader.dart';
import 'package:f_store_dashboard/utils/popups/snackbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CreateProductController extends GetxController {
  // Singleton Instance
  static CreateProductController get instance => Get.find();
  // Observables for loading states and product details
  final isLoading = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  // Controllers and Keys
  final stockPriceFormKey = GlobalKey<FormState>();
  final titleDescFormKey = GlobalKey<FormState>();
  final productRepository = Get.put(ProductRepository());
  final productAttributesController = Get.put(ProductAttributesController());
  final productVariationsController = Get.put(ProductVariationsController());
  final productController = Get.put(ProductController());

  // Text Editing Controllers for input fields
  TextEditingController title = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  // Rx Observables for selected brand and categories
  Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  // Flags for tracking different tasks
  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  // Function to create a new product
  Future<void> createProduct() async {
    try {
      // Show progress dialog
      showProgressDialog();

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        Snackbars.errorSnackBar(
            title: 'Opps!', message: 'No Internet Connection');
        return;
      }
      // Validate Title and Description form
      if (!titleDescFormKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }

      // Validate Stock and Pricing field is productType = ProductType.single
      if (productType.value == ProductType.single &&
          !stockPriceFormKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }

      // Ensure Brand is Selected
      if (selectedBrand.value == null) throw 'Select brand for this product';

      // Check Variation Data if ProductType = ProductType.variable
      if (productType.value == ProductType.variable &&
          productVariationsController.productVariations.isEmpty) {
        throw 'There are no variations for the Product Type variable. Create some variations or change the Product Type';
      }
      if (productType.value == ProductType.variable) {
        final variationCheckFailed =
            productVariationsController.productVariations.any((element) =>
                element.price.isNaN ||
                element.price < 0 ||
                element.salePrice.isNaN ||
                element.salePrice < 0 ||
                element.stock.isNaN ||
                element.stock < 0 ||
                element.image.value.isEmpty);

        if (variationCheckFailed) {
          throw 'Variation data is not accurate. Please recheck variations';
        }
      }

      // Upload Product Thumbnail image
      thumbnailUploader.value = true;
      final ProductImagesController imagesController = Get.put(ProductImagesController());
      if (imagesController.selectedThumbnailImageUrl.value == null) {
        throw 'Select Thumbnail Image';
      }

      // Additional Product Images
      additionalImagesUploader.value = true;

      // Product Variations
      final variations = productVariationsController.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        // Admin added variations and then changed the productType, remove all variations
        productVariationsController.resetAllValues();
        variations.value = [];
      }

      // Map Product Data to ProductModel
      String mainCategory = selectedCategories.isNotEmpty ? selectedCategories.first.id : '';
      final product = ProductModel(
          id: '',
          sku: '',
          isFeatured: true,
          title: title.text.trim(),
          productVariations: variations,
          description: description.text.trim(),
          brand: selectedBrand.value,
          categoryId: mainCategory,
          productType: productType.value.toString(),
          stock: int.tryParse(stock.text.trim()) ?? 0,
          price: double.tryParse(price.text.trim()) ?? 0,
          images: imagesController.additionalProductImageUrls,
          salePrice: double.tryParse(salePrice.text.trim()) ?? 0,
          thumbnail: imagesController.selectedThumbnailImageUrl.value ?? '',
          productAttributes: productAttributesController.productAttributes,
          date: DateTime.now());

      // Call Repository to Create Product
      productDataUploader.value = true;
      product.id = await productRepository.createProduct(product);

      // Register Product Categories if any
      if (selectedCategories.isNotEmpty) {
        if (product.id.isEmpty) throw 'Error storing data. Try again.';

        // Loop through selected product categories
        for (var category in selectedCategories) {
          // Map Data
          final productCategory = ProductCategoryModel(
              categoryId: category.id, productId: product.id);
          await productRepository.createProductCategory(productCategory);
          
        }
      }

      // Update Products List
      productController.addItemToList(product);

      // Close the progress Loader
      FFullScreenLoader.stopLoading();

      // Show Success Message Loader
      showCompletionDialog();
    } catch (e) {
      FFullScreenLoader.stopLoading();
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }

  void resetValues() {
    isLoading(false);
    productType(ProductType.single);
    productVisibility(ProductVisibility.hidden);
    stockPriceFormKey.currentState!.reset();
    titleDescFormKey.currentState!.reset();
    title.clear();
    description.clear();
    stock.clear();
    salePrice.clear();
    price.clear();
    brandTextField.clear();
    selectedCategories.clear();
    selectedBrand(null);
    ProductVariationsController.instance.resetAllValues();
    ProductAttributesController.instance.resetProductAttributes();

    // Reset Upload Flags
    thumbnailUploader(false);
    additionalImagesUploader(false);
    productDataUploader(false);
    categoriesRelationshipUploader(false);
  }

  // Show Progress Dialog
  void showProgressDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Creating Product'),
          content: Obx(() => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    FImages.productsIllustration,
                    width: 200,
                    height: 200,
                  ),
                  const Gap(FSizes.spaceBtwItems),
                  buildCheckbox('Thumbnail Image', thumbnailUploader),
                  buildCheckbox('Additional Images', additionalImagesUploader),
                  buildCheckbox('Product Data, Attributes & Variables',
                      productDataUploader),
                  buildCheckbox(
                      'Product Categories', categoriesRelationshipUploader),
                  const Gap(FSizes.spaceBtwItems),
                  const Text('Sit tight, Your product is uploading')
                ],
              )),
        ),
      ),
    );
  }

  // Build Checkbox Widget
  Widget buildCheckbox(String label, RxBool value) {
    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          child: value.value
              ? const Icon(CupertinoIcons.checkmark_alt_circle_fill)
              : const Icon(CupertinoIcons.checkmark_alt_circle),
        ),
        const Gap(FSizes.spaceBtwItems),
        Text(label),
      ],
    );
  }

  // Show Completion dialog
  void showCompletionDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Congratulations'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: const Text('Go To Products'),
          )
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(FImages.productsIllustration, height: 200, width: 200),
            const Gap(FSizes.spaceBtwItems),
            Text(
              'Congratulations',
              style: Theme.of(Get.context!).textTheme.headlineSmall,
            ),
            const Gap(FSizes.spaceBtwItems),
            const Text('Your product has been created successfully.'),
            const Gap(FSizes.spaceBtwItems),
            const Text(
                'You can now manage your products in the Products section.'),
            const Gap(FSizes.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}
