import 'dart:convert';

import 'package:fstoreapp/data/repositories/products_repository/products_repository.dart';
import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:fstoreapp/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:fstoreapp/utils/local_storage/storage_utility.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController{
  static FavouriteController get instance => Get.find();

  /// Variables
  final favorites =<String, bool>{}.obs;

  @override
  void onInit() {
    initFavorites();
    super.onInit();
  }

  // Method to initialize by reading from storage
  Future<void> initFavorites() async {
    final json = FLocalStorage.instance().readData('favorites');
    if(json != null){
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavorite(String productId){
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId){
    if(!favorites.containsKey(productId)){
      favorites[productId] = true;
      saveFavoritesToStorage();
      Snackbars.customToast(message: 'Product has been added to the Whishlist');
    }else{
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      Snackbars.customToast(message: 'Product has been removed from the Whishlist');
    }
  }

  void saveFavoritesToStorage() {
    final encodedFavorites = jsonEncode(favorites);
    FLocalStorage.instance().writeData('favorites', encodedFavorites);
  }

  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductsRepository.instance.getFavoriteProducts(favorites.keys.toList());
  }
}