import 'package:fstoreapp/features/shop/controllers/product/variation_controller.dart';
import 'package:fstoreapp/features/shop/models/cart_item_model.dart';
import 'package:fstoreapp/features/shop/models/products_model.dart';
import 'package:fstoreapp/utils/constants/enums.dart';
import 'package:fstoreapp/utils/local_storage/storage_utility.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  /// Constructor
  CartController() {
    loadCartItems();
  }

  /// Variables
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  /// Methods
  // Add Items in the cart
  void addToCart(ProductModel product) {
    // Quantity Check
    if (productQuantityInCart.value < 1) {
      Snackbars.customToast(message: 'Select Quantity');
      return;
    }

    // Check Product Type and if a product variation is selected
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      Snackbars.customToast(message: 'Select Variation');
      return;
    }

    // Out of Stock status
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        Snackbars.warningSnackBar(
            message: 'Selected variation is out of stock', title: 'Ohh Snap!');
        return;
      }
    } else {
      if (product.stock < 1) {
        Snackbars.warningSnackBar(
            message: 'Selected Product is out of stock', title: 'Ohh Snap!');
        return;
      }
    }

    // Convert the ProductModel to a CartItemModel with the given quantity
    final selectedCartItem =
        convertToCartItem(product, productQuantityInCart.value);

    // Check if already added in the cart
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == selectedCartItem.productId &&
        cartItem.variationId == selectedCartItem.variationId);

    // If already added, update the quantity, else add to the cart
    if (index >= 0) {
      // This quantity is already added or Updated/Removed from the design (Cart)(-)
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    Snackbars.customToast(message: 'Your Product has been added to the cart');
  }

  /// Add one item to the cart
  void addOneItemToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  /// Remove one item from the cart
  void removeOneItemFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        // Show dialog before completely removing cart item
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
    }

    updateCart();
  }

  /// Remove Item from the cart Dialog
  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        // Remove the item from the cart
        cartItems.removeAt(index);
        updateCart();
        Snackbars.customToast(message: 'Product removed from the cart');
        Get.back();
      },
      onCancel: () => () => Get.back(),
    );
  }

  /// This function converts a ProductModel to a CartItemModel
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      // Reset Variation in case of single product type
      variationController.resetSelectedAttributes();
    }
    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.0
            ? variation.salePrice
            : variation.price
        : product.salePrice > 0.0
            ? product.salePrice
            : product.price;
    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price,
      quantity: quantity,
      variationId: variation.id,
      image: isVariation ? variation.image : product.thumbnail,
      brandName: product.brand != null ? product.brand!.name : '',
      selectedVariations:
          isVariation ? variation.attributes.cast<String, String>() : null,
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  /// Update cart Totals
  void updateCartTotals() {
    totalCartPrice.value = cartItems.fold(
        0.0, (total, cartItem) => total + cartItem.price * cartItem.quantity);

    noOfCartItems.value = cartItems.length;
  }

  /// Update Cart Total
  // void updateCartTotals(){
  //   double calculatedTotalPrice = 0.0;
  //   int calculatedNoOfItems = 0;

  //   for(var item in cartItems){
  //     calculatedTotalPrice += (item.price) * item.quantity.toDouble();
  //     calculatedNoOfItems += item.quantity;
  //   }
  //   totalCartPrice.value = calculatedTotalPrice;
  //   noOfCartItems.value = calculatedNoOfItems;
  // }

  /// Save cart Items to the Local Storage
  void saveCartItems() {
    final cartItemStrings =
        cartItems.map((cartItem) => cartItem.toJson()).toList();
    FLocalStorage.instance().writeData('cartItems', cartItemStrings);
  }

  ///Load Cart Items
  void loadCartItems() {
    final cartItemStrings =
        FLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings.map((cartItem) =>
          CartItemModel.fromJson(cartItem as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  // Check quantity of products in cart
  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((cartItem) => cartItem.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);

    return foundItem;
  }

  // Get Variation Quantity of products in cart
  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
        (cartItem) =>
            cartItem.productId == productId &&
            cartItem.variationId == variationId,
        orElse: () => CartItemModel.empty());

    return foundItem.quantity;
  }

  void clearCart() {
    cartItems.clear();
    productQuantityInCart.value = 0;
    updateCart();
  }

  /// -- Initialize already added items Count in the cart
  void updateAlreadyAddProductCount(ProductModel product) {
    // If product has no variations then calculate cartEntries and display total number
    // Else make default entries to 0 and show cartEntries when variation is selected
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      // Get selected variations if any ...
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value =
            getVariationQuantityInCart(product.id, variationId);
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }
}