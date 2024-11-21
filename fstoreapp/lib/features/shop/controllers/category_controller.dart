import 'package:fstoreapp/data/repositories/categories/category_repository.dart';
import 'package:fstoreapp/data/repositories/products_repository/products_repository.dart';
import 'package:fstoreapp/features/shop/models/category_model.dart';
import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// -- Load category data
  Future<void> fetchCategories() async {
    try {
      // Show loader while loading categories
      isLoading.value = true;

      print('Before Fetching Categories');
      /// Fetch categories from data source (Firestore, API, etc.)
      final categories = await _categoryRepository.getAllCategories();
      // Update the categories list
      allCategories.assignAll(categories);

      // Filter featured categories
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isNotEmpty)
          .take(8)
          .toList());
      print('After Fetching All Categories $featuredCategories');
    } catch (e) {
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// -- Load selected category data
  Future<List<CategoryModel>> getSubCategories({required String categoryId}) async {
    try{
      final subCategories = await _categoryRepository.getSubCategories(categoryId: categoryId);
      return subCategories;
    }catch(e){
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
      return [];
    }
  }

  /// Get Category or sub_category products
  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryId, int limit = 4}) async {
    try {
      // Fetch limited (4) products against each subCategory
      final products = await ProductsRepository.instance
          .getProductsForCategory(categoryId: categoryId, limit: limit);
      return products;
    } catch (e) {
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
      return [];
    }
  }
}
