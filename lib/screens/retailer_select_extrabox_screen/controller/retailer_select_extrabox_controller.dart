import 'package:el_mago/models/product_model/product_model.dart';
import 'package:el_mago/models/retailer_model/retailer_dashboard_summary_model.dart';
import 'package:el_mago/services/repository/sales_dashboard_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/get.dart';

// NEW: A model to hold a product and its quantity in the cart.
class CartItem {
  final ProductModel product;
  var quantity = 1.obs;

  CartItem({required this.product});
}

class RetailerSelectExtraboxController extends GetxController {
  int minimumBoxes = 6;
  var getAllProducts = <ProductModel>[].obs;
  var dashboardSummary = Rx<RetailerDashboardSummaryModel?>(null);
  var isLoading = false.obs;

  SalesDashboardRepository salesDashboardRepository =
      SalesDashboardRepository();

  // --- NEW CART LOGIC ---

  // List to hold selected products (the cart)
  var cart = <CartItem>[].obs;

  // Check if a product is already in the cart
  bool isProductInCart(ProductModel product) {
    return cart.any((item) => item.product.id == product.id);
  }

  // Toggles a product in and out of the cart
  void toggleProductSelection(ProductModel product) {
    if (isProductInCart(product)) {
      cart.removeWhere((item) => item.product.id == product.id);
    } else {
      cart.add(CartItem(product: product));
    }
  }

  // Increase quantity of a cart item
  void incrementQuantity(CartItem cartItem) {
    cartItem.quantity.value++;
  }

  // Decrease quantity or remove item if quantity is 1
  void decrementQuantity(CartItem cartItem) {
    if (cartItem.quantity.value > 1) {
      cartItem.quantity.value--;
    } else {
      cart.remove(cartItem);
    }
  }

  // --- NEW GETTERS FOR SUMMARY ---

  // Calculates total unique products in the cart
  int get totalSelectedProducts => cart.length;

  // Calculates the total number of boxes (sum of all quantities)
  int get totalBoxes => cart.fold(0, (sum, item) => sum + item.quantity.value);

  // Calculates the total price of all items in the cart
  double get totalAmount => cart.fold(
    0.0,
    (sum, item) => sum + (item.product.price * item.quantity.value),
  );

  // --- EXISTING CODE ---

  Future<void> fetchAllProducts() async {
    try {
      var response = await salesDashboardRepository.getProducts();
      if (response.isNotEmpty) {
        getAllProducts.assignAll(response);
        AppPrint.appPrint("getAllProducts Id: ${getAllProducts.first.id}");
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchAllProducts");
    }
  }

  @override
  void onInit() {
    fetchAllProducts();
    super.onInit();
  }
}
