import 'package:fstoreapp/data/repositories/brands_repository/brands_repository.dart';
import 'package:fstoreapp/data/repositories/products_repository/products_repository.dart';
import 'package:fstoreapp/features/shop/models/brand_model.dart';
import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class BrandsController extends GetxController {
  static BrandsController get instance => Get.find();

  final isLoading = false.obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
      final brandsRepository = Get.put(BrandsRepository());

  @override
  void onInit() {
    fetchBrands();
    super.onInit();
  }

  Future<void> fetchBrands() async {
    try {
      isLoading.value = true;
      final brands = await brandsRepository.getAllBrands();
      allBrands.assignAll(brands);
      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false).take(4));
    } catch (e) {
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// -- Get Brands for Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try{
      final brands = await brandsRepository.getBrandsForCategory(categoryId);
      return brands;
    }catch(e){
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message:  e.toString());
      return [];
    }
  }
  
  /// Get Brand specific products from your data source
  Future<List<ProductModel>> getBrandProducts({required String brandId, int limit = -1}) async {
    try{
final products =
          await ProductsRepository.instance.getProductsForBrand(brandId: brandId, limit: limit);
      return products;
    }catch(e){
      Snackbars.errorSnackBar(title: 'Ohh Snap!',message: e.toString());
      return [];
    }
    
  }
}
