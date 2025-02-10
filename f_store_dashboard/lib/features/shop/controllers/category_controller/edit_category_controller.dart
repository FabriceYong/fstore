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

class EditCategoryController extends GetxController {
  static EditCategoryController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final selectedParentCategory = CategoryModel.empty().obs;
  RxString imageUrl = ''.obs;
  final RxBool isFeatured = false.obs;
  final TextEditingController name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Init Data
  void init(CategoryModel category) {
    name.text = category.name;
    imageUrl.value = category.image;
    isFeatured.value = category.isFeatured;
    if (category.parentId.isNotEmpty) {
      selectedParentCategory.value = CategoryController.instance.allItems
          .where((c) => c.id == category.parentId)
          .single;
    }
  }

  Future<void> updateCategory(CategoryModel category) async {
    try {
      FFullScreenLoader.popUpCircular();

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        Snackbars.errorSnackBar(
            title: 'Network Error', message: 'No Internet Connection');
        return;
      }

      if (!formKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }

      // Map Data
      category.image = imageUrl.value;
      category.name = name.text.trim();
      category.parentId = selectedParentCategory.value.id;
      category.isFeatured = isFeatured.value;
      category.updatedAt = DateTime.now();

      // Call Repository to create new User
      final CategoryRepository categoryRepository = Get.put(CategoryRepository());
      await categoryRepository.updateCategory(category);

      // Update All Data List;
      CategoryController.instance.updateItemInList(category);

      // Reset Fields;
      resetFields();

      FFullScreenLoader.stopLoading();
      Snackbars.successSnackbar(
          title: 'Congratulations!',
          message: 'The category has been updated successfully');
    } catch (e) {
      isLoading.value = false;
      FFullScreenLoader.stopLoading();
      print(e);
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }

  /// Pick Thumbnail Image from Media
  void updateImage() async {
    final mediaController = Get.put(MediaController());
    List<ImageModel>? selectedImages =
        await mediaController.selectImageFromMedia();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      imageUrl.value = selectedImage.url;
    }
  }

  // Method to Reset Fields
  resetFields() {
    isFeatured(false);
    imageUrl.value = '';
    name.clear();
    selectedParentCategory(CategoryModel.empty());
    isLoading(false);
  }
}
