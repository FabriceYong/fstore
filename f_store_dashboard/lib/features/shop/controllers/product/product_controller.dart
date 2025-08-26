import 'package:f_store_dashboard/data/abstract/base_data_table_controller.dart';
import 'package:f_store_dashboard/data/repositories/product_repository/product_repository.dart';
import 'package:f_store_dashboard/features/shop/models/product/product_model.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:get/get.dart';

// Define constants for stock thresholds
const int lowStockThreshold = 20;

class ProductController extends FBaseController<ProductModel> {
  static ProductController get instance => Get.find();

  final _productRepository = Get.put(ProductRepository());

  @override
  bool containsSearchQuery(ProductModel item, String query) {
    return item.title.toLowerCase().contains(query.toLowerCase()) ||
        (item.brand != null && item.brand!.name.toLowerCase().contains(query.toLowerCase())) ||
        item.stock.toString().contains(query.toString()) ||
        item.price.toString().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(ProductModel item) async {
    return await _productRepository.deleteProduct(item);
  }

  @override
  Future<List<ProductModel>> fetchItems() async {
    return await _productRepository.getAllProducts();
  }

  /// ------ Sort Products By Name
  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (ProductModel product) => product.title.toLowerCase());
  }

  /// ------- Sort Products by Price
  void sortByPrice(int sortColumnIndex, bool ascending) {
    sortByProperty(
        sortColumnIndex, ascending, (ProductModel product) => product.price);
  }

  /// ------ Sort Products by Stock
  void sortByStock(int sortColumnIndex, bool ascending) {
    sortByProperty(
        sortColumnIndex, ascending, (ProductModel product) => product.stock);
  }

  /// ------- Sort Products by Brand
  void sortByBrand(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (ProductModel product) => product.brand!.name.toLowerCase());
  }

  /// Sort Products by Sold Items
  void sortBySoldItems(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (ProductModel product) => product.soldQuantity);
  }

  /// ------ Get Product Price or Price Range from Variations
  String getProductPrice(ProductModel product) {
    // if no variations exist, return the single price or sale price
    if (product.productType == ProductType.single.toString() ||
        product.productVariations.isEmpty) {
      return (product.salePrice > 0.0 ? product.salePrice : product.price)
          .toString();
    } else {
      double smallestPrice = double.infinity;
      double largestPrice = 0.0;
      for (var variation in product.productVariations) {
        // Determine the price to consider (Sale Price if available, else regular price)
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      // If smallest and largest prices are the same, return a single price
      if (smallestPrice.isEqual(largestPrice)) {
        // Formatting (e.g., adding currency symbols) should ideally be done in the UI layer using a NumberFormat utility.
        return largestPrice.toString();
      } else {
        // Otherwise return price range. Formatting should ideally be done in the UI layer.
        return '$smallestPrice - $largestPrice';
      }
    }
  }

  /// ------ Calculate the Percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  /// ---- Calculate Product Stock
  String getProductStockTotal(ProductModel product) {
    return product.productType == ProductType.single.toString()
        ? product.stock.toString()
        : product.productVariations
            .fold<int>(
                0, (previousValue, element) => previousValue + element.stock)
            .toString();
  }

  /// ------ Calculate Product Sold Quantity
  String getProductsSoldQuantity(ProductModel product) {
    return product.productType == ProductType.single.toString()
        ? product.soldQuantity.toString()
        : product.productVariations
            .fold<int>(
                0,
                (previousValue, element) =>
                    previousValue + element.soldQuantity)
            .toString();
  }

  /// ------ Check Product Stock Status
  String getProductStockStatus(ProductModel product) {
    final stock = int.tryParse(getProductStockTotal(product)) ?? 0;
    if (stock <= 0) return 'Out of Stock';
    if (stock <= lowStockThreshold) return 'Low Stock';
    return 'In Stock';
  }

  /// ------ Filter Products based on selected filter
  void filterProducts(String? filter) {
    if (filter == null || filter.isEmpty) {
      filteredItems.assignAll(allItems);
      return;
    }

    switch (filter) {
      case 'In Stock':
        filteredItems.assignAll(allItems.where((product) {
          final stock = int.tryParse(getProductStockTotal(product)) ?? 0;
          return stock > lowStockThreshold;
        }));
        break;
      case 'Low Stock':
        filteredItems.assignAll(allItems.where((product) {
          final stock = int.tryParse(getProductStockTotal(product)) ?? 0;
          return stock > 0 && stock <= lowStockThreshold;
        }));
        break;
      case 'Out of Stock':
        filteredItems.assignAll(allItems.where((product) {
          final stock = int.tryParse(getProductStockTotal(product)) ?? 0;
          return stock <= 0;
        }));
        break;
      case 'Featured':
        filteredItems
            .assignAll(allItems.where((product) => product.isFeatured == true));
        break;
      default:
        filteredItems.assignAll(allItems);
    }
  }

  // ------ Computed Properties for Stats ------

  int get totalProductsCount => allItems.length;

  int get lowStockCount => allItems.where((product) {
        final stock = int.tryParse(getProductStockTotal(product)) ?? 0;
        return stock > 0 && stock <= lowStockThreshold;
      }).length;

  int get outOfStockCount => allItems.where((product) {
        final stock = int.tryParse(getProductStockTotal(product)) ?? 0;
        return stock <= 0;
      }).length;

  int get featuredCount =>
      allItems.where((product) => product.isFeatured == true).length;
}
