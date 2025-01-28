import 'package:f_store_dashboard/data/repositories/brands_repository/brands_repository.dart';
import 'package:f_store_dashboard/features/shop/models/brand_model/brand_model.dart';
import 'package:f_store_dashboard/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandsController extends GetxController {
  static BrandsController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> filteredBrands = <BrandModel>[].obs;
  final BrandsRepository _brandModel = Get.put(BrandsRepository());

  // Search Field
  final TextEditingController searchFilter = TextEditingController();

  // Sorting
  final sortColumnIndex = 1.obs;
  final sortAscending = false.obs;

  @override
  void onInit() {
    fetchBrands();
    super.onInit();
  }

  Future<void> fetchBrands() async {
    try {
      isLoading.value = true;

      List<BrandModel> fetchedBrands = [];
      if (fetchedBrands.isEmpty) {
        fetchedBrands = await _brandModel.getAllBrands();
      }
      allBrands.assignAll(fetchedBrands);
      filteredBrands.assignAll(fetchedBrands);

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('Error: $e');
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }
  }

  searchBrands(String query) {
    filteredBrands.assignAll(allBrands.where(
        (brand) => brand.name.toLowerCase().contains(query.toLowerCase())));
  }

  sortBrandsByName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    if (ascending) {
      return filteredBrands.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
    } else {
      return filteredBrands
          .sort((a, b) => b.name.toLowerCase().compareTo(b.name.toLowerCase()));
    }
  }
}
