import 'package:f_store_dashboard/data/repositories/category_repository/category_repository.dart';
import 'package:f_store_dashboard/features/media/controllers/media_controller.dart';
import 'package:f_store_dashboard/features/media/models/image_model.dart';
import 'package:f_store_dashboard/features/shop/controllers/category_controller/category_controller.dart';
import 'package:f_store_dashboard/features/shop/models/category_model/category_model.dart';
import 'package:f_store_dashboard/utils/helpers/network_manager.dart';
import 'package:f_store_dashboard/utils/loaders/full_screen_loader.dart';
import 'package:f_store_dashboard/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCategoryController extends GetxController {
  static CreateCategoryController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final selectedParentCategory = CategoryModel.empty().obs;
  RxString imageUrl = ''.obs;
  final RxBool isFeatured = false.obs;
  final TextEditingController name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Method to Reset Fields

  /// Register New Category

  Future<void> createNewCategory() async {
    try {
      FFullScreenLoader.popUpCircular();

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        Snackbars.errorSnackBar(
            title: 'Network Error', message: 'No Internet Connection');
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }

      // Create Category Model
      final CategoryModel newCategory = CategoryModel(
        id: '',
        name: name.text.trim(),
        image: imageUrl.value,
        isFeatured: isFeatured.value,
        parentId: selectedParentCategory.value.id,
        createdAt: DateTime.now(),
      );

      // Create Category in Firestore
      final CategoryRepository categoryRepository =
          Get.put(CategoryRepository());

      newCategory.id = await categoryRepository.createCategory(newCategory);

      // Add newly created category to List
      CategoryController.instance.addItemToList(newCategory);

      // Reset Fields
      resetFields();

      // Stop Loader
      FFullScreenLoader.stopLoading();
      // Show success Snackbar
      Snackbars.successSnackbar(
          title: 'Congratulations!',
          message: 'The new category has been created successfully.');
    } catch (e) {
      print('Error: $e');
      FFullScreenLoader.stopLoading();
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }

  /// Pick Thumbnail Image from Media
  void pickImage() async {
    final mediaController = Get.put(MediaController());
    List<ImageModel>? selectedImages =
        await mediaController.selectImageFromMedia();

    // Handle the selected Image
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Set the selected Image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Update the main image using the selectedImage
      imageUrl.value = selectedImage.url;
    }
  }

  void resetFields() {
    isLoading(false);
    name.clear();
    imageUrl.value = '';
    isFeatured(false);
    selectedParentCategory(CategoryModel.empty());
  }
}
