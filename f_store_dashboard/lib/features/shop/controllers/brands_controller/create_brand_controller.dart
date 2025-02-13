import 'package:f_store_dashboard/data/repositories/brands_repository/brands_repository.dart';
import 'package:f_store_dashboard/features/media/controllers/media_controller.dart';
import 'package:f_store_dashboard/features/media/models/image_model.dart';
import 'package:f_store_dashboard/features/shop/controllers/brands_controller/brands_controller.dart';
import 'package:f_store_dashboard/features/shop/models/brand_model/brand_category_model.dart';
import 'package:f_store_dashboard/features/shop/models/brand_model/brand_model.dart';
import 'package:f_store_dashboard/features/shop/models/category_model/category_model.dart';
import 'package:f_store_dashboard/utils/helpers/network_manager.dart';
import 'package:f_store_dashboard/utils/loaders/full_screen_loader.dart';
import 'package:f_store_dashboard/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBrandController extends GetxController {
  static CreateBrandController get instance => Get.find();

  final isLoading = false.obs;
  RxString imageUrl = ''.obs;
  final RxBool isFeatured = false.obs;
  final TextEditingController name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  final repository = Get.put(BrandsRepository());
  final brandsController = Get.put(BrandsController());

  /// Toggle Category Selection
  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  /// Reset Fields
  void resetFields() {
    isLoading(false);
    imageUrl('');
    isFeatured(false);
    name.clear();
    selectedCategories.clear();
  }

  /// Pick thumbnail image from Media
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImageFromMedia();

    // Handle the selected image
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Set the selected image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Update the main image using the selected image
      imageUrl(selectedImage.url);
    }
  }

  /// Register A New Brand
  Future<void> createBrand() async {
    try {
      FFullScreenLoader.popUpCircular();

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        Snackbars.errorSnackBar(
            title: 'Ohh Snap!', message: 'No Internet Connection');
        return;
      }

      // Validate Form
      if (!formKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }

      // Create Brand
      BrandModel newBrand = BrandModel(
        id: '',
        name: name.text.trim(),
        image: imageUrl.value,
        productsCount: 0,
        isFeatured: isFeatured.value,
        createdAt: DateTime.now(),
      );

      // Save Brand to Firestore
      final brandId = await repository.createBrand(newBrand);
      // update brandId
      newBrand.id = brandId;

      // Register brand selectedCategories if any
      if (selectedCategories.isNotEmpty) {
        if (newBrand.id.isEmpty)
          throw 'Error storing relation data. Please try again';

        for (var category in selectedCategories) {
          final brandCategory = BrandCategoryModel(
              id: '', brandId: newBrand.id, categoryId: category.id);
          brandCategory.id = await repository.createBrandCategory(brandCategory);
        }

        newBrand.brandCategories ??= [];
        newBrand.brandCategories!.addAll(selectedCategories);
      }

      // Update all Data List
      brandsController.addItemToList(newBrand);
      // await Get.find<BrandsController>().refreshBrands();

      // Reset Fields
      resetFields();

      // Remove Loader
      FFullScreenLoader.stopLoading();
      // Show Snackbar
      Snackbars.successSnackbar(
          title: 'Congratulations!', message: 'Brand Created Successfully');
    } catch (e) {
      FFullScreenLoader.stopLoading();
      print(e);
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }
}
