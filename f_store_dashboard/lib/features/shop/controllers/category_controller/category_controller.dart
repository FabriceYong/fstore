import 'package:f_store_dashboard/data/repositories/category_repository/category_repository.dart';
import 'package:f_store_dashboard/features/shop/models/category_model/category_model.dart';
import 'package:f_store_dashboard/utils/dialogs/dialog.dart';
import 'package:f_store_dashboard/utils/loaders/full_screen_loader.dart';
import 'package:f_store_dashboard/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  final RxList<CategoryModel> filteredCategories = <CategoryModel>[].obs;
  final CategoryRepository _categoryRepository = Get.put(CategoryRepository());
  final RxList<bool> selectedRows = <bool>[].obs;

  // Sorting
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = false.obs;

  // Search TextField
  final searchTextController = TextEditingController();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<CategoryModel> fetchCategories = [];
      if (allCategories.isEmpty) {
        fetchCategories = await _categoryRepository.getAllCategories();
      }

      allCategories.assignAll(fetchCategories);
      filteredCategories.assignAll(fetchCategories);
      selectedRows.assignAll(List.generate(allCategories.length, (_) => false));

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('Error fetching category data: $e');
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }

  /// Sort Categories by Name
  void sortByName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    if (ascending) {
      return filteredCategories
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    } else {
      return filteredCategories
          .sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
    }
  }

  // Sort Categories by Parent Name
  sortByParentName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    if (ascending) {
      return filteredCategories
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    } else {
      return filteredCategories
          .sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
    }
  }

  // Search Field
  void searchQuery(String query) {
    filteredCategories.assignAll(allCategories.where((category) =>
        category.name.toLowerCase().contains(query.toLowerCase())));
  }

  // Delete Category Confirmation
  confirmAndDeleteCategory(CategoryModel category) {
    FDialogs.defaultDialog(
        context: Get.context!,
        title: 'Delete Category!',
        content: 'Are you sure you want to delete this category?',
        positive: 'Delete',
        negative: 'Cancel',
        onPositive: () => deleteCategory(category));
  }

  // Delete Category API Call
  void deleteCategory(CategoryModel category) async {
    try {
// Remove Loader
      FFullScreenLoader.stopLoading();

      // Start the Loader
      FFullScreenLoader.popUpCircular();

      // API Call
      await _categoryRepository.deleteCategory(category.id);

      // Update List
      removeItemFromList(category);

      // Stop the Loader
      FFullScreenLoader.stopLoading();
      Snackbars.successSnackbar(
          title: 'Deleted!', message: 'Category deleted successfully');
    } catch (e) {
      FFullScreenLoader.stopLoading();
      Snackbars.errorSnackBar(title: 'Oops!', message: e.toString());
    }
  }

  // Remove Item from List
  void removeItemFromList(CategoryModel category) {
    allCategories.remove(category);
    filteredCategories.remove(category);
    selectedRows
        .assignAll(List.generate(allCategories.length, (index) => false));
    // selectedRows.removeAt(allCategories.indexOf(category));

    update();
  }

  // Add Items To List
  void addItemToList(CategoryModel newCategory) {
    allCategories.add(newCategory);
    filteredCategories.add(newCategory);
    selectedRows.assignAll(List.generate(
        allCategories.length, (_) => false)); // Initialize selected Rows

    filteredCategories.refresh(); // Refresh the UI to reflect changes
  }

  // Update Items In The List
  void updateItemsFromList(CategoryModel category) {
    final itemIndex = allCategories.indexWhere((item) => item == category);
    final filteredItemIndex =
        filteredCategories.indexWhere((item) => item == category);

    if (itemIndex != -1) {
      allCategories[itemIndex] = category;
    }

    if (filteredItemIndex != -1) {
      filteredCategories[filteredItemIndex] = category;
    }

    filteredCategories.refresh(); // Refresh the UI to reflect the changes
  }
}
