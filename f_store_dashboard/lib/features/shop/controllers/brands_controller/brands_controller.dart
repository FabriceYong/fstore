import 'package:f_store_dashboard/data/abstract/base_data_table_controller.dart';
import 'package:f_store_dashboard/data/repositories/brands_repository/brands_repository.dart';
import 'package:f_store_dashboard/features/shop/controllers/category_controller/category_controller.dart';
import 'package:f_store_dashboard/features/shop/models/brand_model/brand_model.dart';
import 'package:get/get.dart';

class BrandsController extends FBaseController<BrandModel> {
  static BrandsController get instance => Get.find();

  final _brandRepository = Get.put(BrandsRepository());
  final _categoryController = Get.put(CategoryController());

  @override
  bool containsSearchQuery(BrandModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(BrandModel item) {
    return _brandRepository.deleteBrand(item);
  }

  @override
  Future<List<BrandModel>> fetchItems() async {
    // Fetch Brands
    final fetchedBrands = await _brandRepository.getAllBrands();

    // Fetch brand categories relational data
    final brandCategories = await _brandRepository.getAllBrandCategories();

    // Fetch all categories if data does not already exist
    if (_categoryController.allItems.isNotEmpty) {
      await _categoryController.fetchItems();
    }

    // Loop all brands and fetch categories of each
    for (var brand in fetchedBrands) {
      List<String> categoryIds = brandCategories
          .where((brandCategory) => brandCategory.brandId == brand.id)
          .map((brandCategory) => brandCategory.categoryId)
          .toList();

      brand.brandCategories = _categoryController.allItems
          .where((category) => categoryIds.contains(category.id))
          .toList();
    }

    return fetchedBrands;
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(
        sortColumnIndex, ascending, (BrandModel b) => b.name.toLowerCase());
  }

  Future<void> refreshBrands() async {
    await fetchItems();
    update();
  }
}
