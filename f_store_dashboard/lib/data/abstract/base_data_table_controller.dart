import 'package:f_store_dashboard/utils/dialogs/dialog.dart';
import 'package:f_store_dashboard/utils/loaders/full_screen_loader.dart';
import 'package:f_store_dashboard/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class FBaseController<T> extends GetxController {
  final isLoading = false.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = false.obs;
  RxList<T> allItems = <T>[].obs;
  RxList<T> filteredItems = <T>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  /// Abstract Method to be implemented by sub-classes for fetching Items
  Future<List<T>> fetchItems();

  /// Abstract Method to be implemented by sub-classes for deleting an Item
  Future<void> deleteItem(T item);

  /// Abstract Method to be implemented by sub-classes for checking if an Item contains the search query
  bool containsSearchQuery(T item, String query);

  /// Common Method For Fetching Data;
  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<T> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems =
            await fetchItems(); // Fetch Items (To Be Implemented in Sub-Classes)
      }

      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(fetchedItems);
      selectedRows.assignAll(List.generate(allItems.length, (_) => false));
    } catch (e) {
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Common method for searching based on a query
  void searchItems(String query) {
    filteredItems
        .assignAll(allItems.where((item) => containsSearchQuery(item, query)));
  }

  /// Common Method For Sorting Items By A Property
  void sortByProperty(
      int sortColumnIndex, bool sortAscending, Function(T) property) {
    this.sortColumnIndex.value = sortColumnIndex;
    this.sortAscending.value = sortAscending;

    filteredItems.sort((a, b) {
      final aValue = property(a);
      final bValue = property(b);

      if (sortAscending) {
        return aValue.compareTo(bValue);
      } else {
        return bValue.compareTo(aValue);
      }
    });
  }

  /// Common Method For Adding An Item To The List;
  void addItemToList(T item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));

    filteredItems.refresh();
  }

  /// Common Method For Updating An Item In The List;
  void updateItemInList(T item) {
    final itemIndex = allItems.indexWhere((i) => i == item);
    final filteredItemIndex =
        filteredItems.indexWhere((filteredItem) => filteredItem == item);

    if (itemIndex != -1) allItems[itemIndex] = item;
    if (filteredItemIndex != -1) filteredItems[filteredItemIndex] = item;

    filteredItems.refresh();
  }

  // Delete Category Confirmation
  conformDeleteItem(T item) {
    FDialogs.defaultDialog(
        context: Get.context!,
        title: 'Delete Item!',
        content: 'Are you sure you want to delete this item?',
        positive: 'Delete',
        negative: 'Cancel',
        onPositive: () => delete(item));
  }

  /// Common Method For Removing Item From List;
  void removeItemFromList(T item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(allItems.length, (item) => false));

    update();
  }

  // Delete Category API Call
  Future<void> delete(T item) async {
    try {
// Remove Loader
      FFullScreenLoader.stopLoading();

      // Start the Loader
      FFullScreenLoader.popUpCircular();

      // API Call
      await deleteItem(item);

      // Update List
      removeItemFromList(item);

      // Stop the Loader
      FFullScreenLoader.stopLoading();
      Snackbars.successSnackbar(
          title: 'Deleted!', message: 'Item deleted successfully');
    } catch (e) {
      FFullScreenLoader.stopLoading();
      Snackbars.errorSnackBar(title: 'Oops!', message: e.toString());
    }
  }
}
