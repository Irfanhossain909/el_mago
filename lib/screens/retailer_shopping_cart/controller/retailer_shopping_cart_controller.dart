import 'package:el_mago/models/product_model/product_model.dart';
import 'package:el_mago/screens/sales_shopping_cart/model/cart_item_model.dart';
import 'package:get/get.dart';

class RetailerShoppingCartController extends GetxController {
  var cartItems = <CartItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Add sample data for testing
    _addSampleData();
  }

  void _addSampleData() {
    final sampleProducts = [
      ProductModel(
        id: "1",
        name: "Premium Coffee Beans",
        size: "500g",
        perBoxQty: 12,
        totalInventoryValue: 1000,
        quantity: 50,
        price: 25,
        images: [],
        lowStockAlert: false,
      ),
      ProductModel(
        id: "2",
        name: "Organic Tea Bags",
        size: "200g",
        perBoxQty: 24,
        totalInventoryValue: 800,
        quantity: 30,
        price: 18,
        images: [],
        lowStockAlert: true,
      ),
      ProductModel(
        id: "3",
        name: "Chocolate Bars",
        size: "100g",
        perBoxQty: 36,
        totalInventoryValue: 1200,
        quantity: 75,
        price: 15,
        images: [],
        lowStockAlert: false,
      ),
    ];

    for (var product in sampleProducts) {
      cartItems.add(CartItemModel(product: product, initialQuantity: 2));
    }
  }

  // --- Cart Methods ---
  void addProductToCart(ProductModel product) {
    var existingItem = cartItems.firstWhereOrNull(
      (item) => item.product.id == product.id,
    );
    if (existingItem != null) {
      existingItem.quantity.value++;
    } else {
      cartItems.add(CartItemModel(product: product));
    }
  }

  void incrementItem(String productId) {
    var item = cartItems.firstWhereOrNull(
      (item) => item.product.id == productId,
    );
    if (item != null) {
      item.quantity.value++;
    }
  }

  void decrementItem(String productId) {
    var item = cartItems.firstWhereOrNull(
      (item) => item.product.id == productId,
    );
    if (item != null && item.quantity.value > 1) {
      item.quantity.value--;
    } else if (item != null && item.quantity.value == 1) {
      cartItems.remove(item);
    }
  }

  double get totalAmount =>
      cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  int get totalBoxCount =>
      cartItems.fold(0, (sum, item) => sum + item.quantity.value);

  void clearCart() {
    cartItems.clear();
  }
}
