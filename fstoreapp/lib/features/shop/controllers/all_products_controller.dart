import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fstoreapp/data/repositories/products_repository/products_repository.dart';
import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductsRepository.instance;
  final isLoading = false.obs;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      isLoading.value = true;
      if (query == null) return [];

      final products = await repository.fetchProductsByQuery(query);

      return products;
    } catch (e) {
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
      return [];
    }finally{
      isLoading.value = false;
    }
  }

  /// Sort Products
  void sortProducts(String sortOption){
    selectedSortOption.value = sortOption;

    switch(sortOption){
      case 'Name': 
      products.sort((a, b) => a.title.compareTo(b.title));
      break;
      case 'Higher Price':
      products.sort((a, b) => b.price.compareTo(a.price));
      break;
      case 'Lower Price':
      products.sort((a, b) => a.price.compareTo(b.price));
      break;
      case 'Newest':
      products.sort((a, b) => a.date!.compareTo(b.date!));
      break;
      case 'Sale': 
      products.sort((a, b) {
        if(b.salePrice > 0){
          return b.salePrice.compareTo(a.salePrice);
        }else if(a.salePrice > 0){
          return -1;
        }else return 1;
      });
      break;
      default:
      // Default sorting option: Name
      products.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  void assignProducts(List<ProductModel> products){
    // Assign Products to the 'products' list
    this.products.assignAll(products);
    sortProducts('Name');
  }
}
