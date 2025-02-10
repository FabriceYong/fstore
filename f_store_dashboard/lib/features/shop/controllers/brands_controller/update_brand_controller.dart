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

class UpdateBrandController extends GetxController {
  static UpdateBrandController get instance => Get.find();

  final isLoading = false.obs;
  RxString imageUrl = ''.obs;
  final RxBool isFeatured = false.obs;
  final TextEditingController name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  final repository = Get.put(BrandsRepository());

  void init(BrandModel brand) {
    name.text = brand.name;
    imageUrl.value = brand.image;
    isFeatured.value = brand.isFeatured;
    if (brand.brandCategories != null) {
      selectedCategories.addAll(brand.brandCategories ?? []);
    }
  }

  // Toggle Categories selection
  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  // Reset Fields
  void resetFields() {
    isLoading(false);
    imageUrl('');
    isFeatured(false);
    name.clear();
    selectedCategories.clear();
  }

  // Pick category image
  void pickImage() async {
    final mediaController = Get.put(MediaController());
    List<ImageModel>? selectedImages =
        await mediaController.selectImageFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      imageUrl(selectedImage.url);
    }
  }

// Update category
  Future<void> updateBrand(BrandModel brand) async {
    try {
      FFullScreenLoader.popUpCircular();

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        Snackbars.errorSnackBar(
            title: 'Ohh Snap!', message: 'No Internet Connection');
        return;
      }

      if (!formKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }

      // Map Data
      bool isBrandUpdated = false;
      if (brand.name != name.text.trim() ||
          brand.image != imageUrl.value ||
          brand.isFeatured != isFeatured.value) {
        isBrandUpdated = true;

        // Map data
        brand.image = imageUrl.value;
        brand.name = name.value.text.trim();
        brand.isFeatured = isFeatured.value;
        brand.updatedAt = DateTime.now();

        // Call the repository to update brand
        await repository.updateBrand(brand);
      }

      // Update BrandCategories
      if (selectedCategories.isNotEmpty) await updateBrandCategories(brand);

      // Update Brand Data in Products
      if(isBrandUpdated) await updateBrandInProducts(brand);

      // Update All Data in List
      BrandsController.instance.updateItemInList(brand);

      // Update UI Listeners
      update();

      resetFields();

      FFullScreenLoader.stopLoading();
      Snackbars.successSnackbar(
          title: 'Congratulations', message: 'Brand updated successfully');
    } catch (e) {
      FFullScreenLoader.stopLoading();
      print(e);
      Snackbars.errorSnackBar(
          title: 'Ohh Snap!',
          message: 'Something went wrong. Please try again');
    }
  }

  /// Update Categories of this Brand
  updateBrandCategories(BrandModel brand) async {
    // Fetch All BrandCategories
    final brandCategories =
        await repository.getCategoriesOfSpecificBrand(brand.id);

    // Selected Categories
    final selectedCategoryIds =
        selectedCategories.map((selectedCategory) => selectedCategory.id);

    // Identify Categories to Remove
    final categoriesToRemove = brandCategories
        .where((existingCategory) =>
            !selectedCategoryIds.contains(existingCategory.categoryId))
        .toList();

    // Remove Categories
    for (var categoryToRemove in categoriesToRemove) {
      await repository.deleteBrandCategory(categoryToRemove.id ?? '');
    }

    // Identify Categories to Add
    final newCategoriesToAdd = selectedCategories
        .where((newCategory) => !brandCategories.any((existingCategory) =>
            existingCategory.categoryId == newCategory.id))
        .toList();

    // Add New Categories
    for (var newCategory in newCategoriesToAdd) {
      var brandCategory = BrandCategoryModel(
          id: '', brandId: brand.id, categoryId: newCategory.id);
      brandCategory.id = await repository.createBrandCategory(brandCategory);
    }

    brand.brandCategories!.assignAll(selectedCategories);
    BrandsController.instance.updateItemInList(brand);
  }
  
  /// Update Products of this Brand
  updateBrandInProducts(BrandModel brand) {}
}
