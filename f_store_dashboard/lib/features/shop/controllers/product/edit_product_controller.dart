import 'package:f_store_dashboard/data/repositories/product_repository/product_repository.dart';
import 'package:f_store_dashboard/features/shop/controllers/category_controller/category_controller.dart';
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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class EditProductController extends GetxController {
  // Singleton Instance
  static EditProductController get instance => Get.find();
  // Observables for loading states and product details
  final isLoading = false.obs;
  Rx<ProductType> productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;
  final selectedCategoriesLoader = false.obs;

  // Controllers and Keys
  final stockPriceFormKey = GlobalKey<FormState>();
  final titleDescFormKey = GlobalKey<FormState>();
  final productRepository = Get.put(ProductRepository());
  final imagesController = Get.put(ProductImagesController());
  final variationsController = Get.put(ProductVariationsController());
  final attributesController = Get.put(ProductAttributesController());

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
  RxList<CategoryModel> alreadyAddedCategories = <CategoryModel>[].obs;

  // Flags for tracking different tasks
  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Get product from arguments when controller initializes
    final product = Get.arguments as ProductModel?;
    if (product != null) {
      initProdData(product);
    } else {
      // Handle case where product is not passed correctly
      Snackbars.errorSnackBar(title: 'Error', message: 'Product data not found.');
      Get.back(); // Optionally navigate back if product is missing
    }
  }

  // Initialize Product Data;
  Future<void> initProdData(ProductModel product) async { // Make async
    try {
      isLoading.value = true; // Set Loading State while initializing the data;

      // Basic Information
      title.text = product.title;
      description.text = product.description ?? '';
      productType.value = product.productType == ProductType.single.toString()
          ? ProductType.single
          : ProductType.variable;

      // Load Categories - Moved here and awaited
      await loadSelectedCategories(product.id);

      if (productType.value == ProductType.single) { // Corrected comparison
        stock.text = product.stock.toString();
        price.text = product.price.toString();
        salePrice.text = product.salePrice.toString();
      }

      // Product Brand
      selectedBrand.value = product.brand;
      brandTextField.text = product.brand?.name ?? '';

      // Product Thumbnail Image
      if (product.images != null) {
        // Set the first Image as the thumbnail
        imagesController.selectedThumbnailImageUrl.value = product.thumbnail;

        // Add the images to Additional Images
        imagesController.additionalProductImageUrls
            .assignAll(product.images ?? []);

        // Product Attributes and Variations (Assuming you have a method to fetch variations in ProductVariationsController)
        attributesController.productAttributes
            .assignAll(product.productAttributes ?? []);
        variationsController.productVariations
            .assignAll(product.productVariations ?? []);
        variationsController
            .initializeVariationControllers(product.productVariations ?? []);
      }
      // Removed loadSelectedCategories from here

    } catch (e) {
      // Ensure isLoading is false even if an error occurs
      isLoading.value = false;
      if (kDebugMode) print(e);
    } finally { // Move finally block inside initProdData
      // Ensure isLoading is false after completion or error
      isLoading.value = false;
      update(); // Update UI after loading finishes
    }
  } // End of initProdData


  Future<List<CategoryModel>> loadSelectedCategories(String productId) async {
    try {
      selectedCategoriesLoader.value = true; // Set loader to true
      // Product Categories
      final productCategories =
          await productRepository.getProductCategories(productId);
    // Categories Controller
    final categoriesController = Get.put(CategoryController());
    if (categoriesController.allItems.isEmpty) {
      await categoriesController.fetchItems();
    }

    final categoryIds =
        productCategories.map((category) => category.categoryId).toList();
    final categories = categoriesController.allItems
        .where((category) => categoryIds.contains(category.id))
        .toList();
      selectedCategories.assignAll(categories);
      alreadyAddedCategories.assignAll(categories);

      return categories;
    } catch (e) {
      Snackbars.errorSnackBar(title: 'Error loading categories', message: e.toString());
      return []; // Return empty list on error
    } finally {
      selectedCategoriesLoader.value = false; // Set loader to false in finally block
    }
  }

  // Function to create a new product
  Future<void> editProduct(ProductModel product) async {
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
          ProductVariationsController.instance.productVariations.isEmpty) {
        throw 'There are no variations for the Product Type variable. Create some variations or change the Product Type';
      }
      if (productType.value == ProductType.variable) {
        final variationCheckFailed = ProductVariationsController
            .instance.productVariations
            .any((element) =>
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
      final imagesController = ProductImagesController.instance;
      if (imagesController.selectedThumbnailImageUrl.value == null) {
        throw 'Select Thumbnail Image';
      }

      // Additional Product Images
      additionalImagesUploader.value = true;

      // Product Variations
      final variations = ProductVariationsController.instance.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        // Admin added variations and then changed the productType, remove all variations
        ProductVariationsController.instance.resetAllValues();
        variations.value = [];
      }

      // Map Product Data to ProductModel

      product.sku = '';
      product.isFeatured = true;
      product.title = title.text.trim();
      product.brand = selectedBrand.value;
      product.description = description.text.trim();
      product.productType = productType.value.toString();
      product.stock = int.tryParse(stock.text.trim()) ?? 0;
      product.price = double.tryParse(price.text.trim()) ?? 0.0;
      product.images = imagesController.additionalProductImageUrls;
      product.salePrice = double.tryParse(salePrice.text.trim()) ?? 0.0;
      product.thumbnail =
          imagesController.selectedThumbnailImageUrl.value ?? '';
      product.productAttributes =
          ProductAttributesController.instance.productAttributes;
      product.productVariations = variations;

      // Call Repository to Create Product
      productDataUploader.value = true;
      await productRepository.updateProduct(product);

      // Register Product Categories if any
      if (selectedCategories.isNotEmpty) {
        if (product.id.isEmpty) throw 'Error storing data. Try again.';

        // Get the existing categoryIds
        List<String> existingCategoryIds =
            alreadyAddedCategories.map((category) => category.id).toList();

        // Loop through selected product categories
        for (var category in selectedCategories) {
          // Check if the category is not already associated with the product
          if (!existingCategoryIds.contains(category.id)) {
            // Map Data
            final productCategory = ProductCategoryModel(
                categoryId: category.id, productId: product.id);
            await productRepository.createProductCategory(productCategory);
          }

          // Remove Categories not selected by the user
          for (var existingCategoryId in existingCategoryIds) {
            // Check if the category is not present in the selected Categories
            if (!selectedCategories
                .any((category) => category.id == existingCategoryId)) {
              // Remove Association
              await productRepository.removeProductCategory(
                  product.id, existingCategoryId);
            }
          }
        }
      }

      // Update Products List
      ProductController.instance.addItemToList(product);

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
                  const Text('Sit tight, your product is uploading'),
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
            const Text('Your product has been updated successfully.'),
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
