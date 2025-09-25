import 'package:el_mago/models/product_model/product_model.dart';
import 'package:el_mago/screens/controller/global_controller.dart';
import 'package:el_mago/screens/sales_shopping_cart/model/cart_item_model.dart';
import 'package:get/get.dart';

class SalesShoppingCartController extends GetxController {
  // Instance of the global controller to access the master product list
  final GlobalController globalController = Get.find<GlobalController>();

  // Observable list to hold the items in the shopping cart
  var cartItems = <CartItemModel>[].obs;

  // Method to add a product to the cart
  void addProductToCart(ProductModel product) {
    // Check if the product is already in the cart
    var existingItem = cartItems.firstWhereOrNull(
      (item) => item.product.id == product.id,
    );

    if (existingItem != null) {
      // If it exists, just increase the quantity
      existingItem.quantity.value++;
    } else {
      // If not, add a new CartItemModel to the list
      cartItems.add(CartItemModel(product: product));
    }
  }

  // Method to increment item quantity
  void incrementQuantity(CartItemModel item) {
    item.quantity.value++;
  }

  // Method to decrement item quantity
  void decrementQuantity(CartItemModel item) {
    if (item.quantity.value > 1) {
      item.quantity.value--;
    } else {
      // If quantity becomes less than 1, remove the item from the cart
      removeItemFromCart(item);
    }
  }

  // Method to remove an item from the cart
  void removeItemFromCart(CartItemModel item) {
    cartItems.remove(item);
  }

  // Method to remove all items from the cart
  void removeAllItems() {
    cartItems.clear();
  }

  // Calculated property for the total amount of all items in the cart
  double get totalAmount =>
      cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  // Calculated property for the total box of all items in the cart
  int get totalBox =>
      cartItems.fold(0, (sum, item) => sum + item.quantity.value);
}
