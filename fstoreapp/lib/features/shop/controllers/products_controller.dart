import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:fstoreapp/utils/constants/enums.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try {
      // Show Loader while loading products
      isLoading.value = true;

      // Fetch Products

      // Assign Product
    } catch (e) {
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Get the product price or price range for variations
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // If no variation exists, return the simple price or sale price
    if (product.productType == ProductType.single.name) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      // Calculate the smallest and largest price among variations
      for (var variation in product.productVariations!) {
        // Determine the price to consider (sale price if available, otherwise regular price)
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // Update smallest and largest prices
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          smallestPrice = priceToConsider;
        }
      }
      // If smallest and largest prices are the same, return a single price
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        // Otherwise, return a price range
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }

  /// -- Calculate Discount Percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double discount = ((originalPrice - salePrice) / originalPrice) * 100;
    return discount.toStringAsFixed(0);
  }

  /// -- Check Product Stock Status
  String getProductsStocksStatus(int stock){
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
