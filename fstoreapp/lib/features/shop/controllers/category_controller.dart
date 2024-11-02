import 'package:fstoreapp/data/repositories/categories/category_repository.dart';
import 'package:fstoreapp/features/shop/models/category_model.dart';
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

      /// Fetch categories from data source (Firestore, API, etc.)
      final categories = await _categoryRepository.getAllCategories();

      // Update the categories list
      allCategories.assignAll(categories);

      // Filter featured categories
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// -- Load selected category data

  /// Get Category or sub_category products
}
