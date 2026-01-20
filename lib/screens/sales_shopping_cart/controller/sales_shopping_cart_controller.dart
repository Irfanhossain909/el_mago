import 'package:el_mago/models/product_model/product_model.dart';
import 'package:el_mago/models/retailer_model/retailer_model.dart';
import 'package:el_mago/screens/controller/global_controller.dart';
import 'package:el_mago/screens/sales_shopping_cart/model/cart_item_model.dart';
import 'package:el_mago/services/repository/order_repository.dart';
import 'package:el_mago/services/repository/sales_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesShoppingCartController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();
  final SalesRepository _salesRepository = Get.find<SalesRepository>();
  final OrderRepository _orderRepository = Get.find<OrderRepository>();

  // Observables for cart
  var cartItems = <CartItemModel>[].obs;
  var isPlacingOrder = false.obs;

  // Observables for retailers dropdown
  var retailers = <RetailerModel>[].obs;
  var isRetailerLoading = true.obs;
  var selectedRetailerId = Rx<String?>(null);

  // Observables for Payment Terms Dropdown
  final List<String> paymentTerms = ['Due on Receipt', 'Net 15', 'Net 30'];
  var selectedTerm = 'Due on Receipt'.obs;

  // Controller for the notes text field
  final TextEditingController notesController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchRetailers();
  }

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }

  // --- Place Order Logic ---
  Future<void> placeOrder() async {
    // Validation
    final selectedRetailer = retailers.firstWhereOrNull(
      (r) => r.id == selectedRetailerId.value,
    );

    if (selectedRetailer == null) {
      Get.snackbar(
        "Error",
        "Please select a retailer.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (cartItems.isEmpty) {
      Get.snackbar(
        "Error",
        "Your cart is empty.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isPlacingOrder(true);

      // --- FIX: Create the userId object with retailer info ---
      // final Map<String, dynamic> userIdPayload = {
      //   "_id": selectedRetailer.id,
      //   "name": selectedRetailer.name,
      // };

      // Construct the products list for the request body
      final List<Map<String, dynamic>> productsPayload = cartItems.map((item) {
        // Calculate back order if cart quantity exceeds available stock
        int availableStock = item.product.quantity;
        int cartQuantity = item.quantity.value;
        int fulfillableQuantity;
        int backOrderQuantity;

        if (availableStock <= 0) {
          // If stock is 0 or negative, entire order quantity is back order
          fulfillableQuantity = 0;
          backOrderQuantity = cartQuantity;
        } else if (cartQuantity > availableStock) {
          // If order quantity exceeds positive stock, fulfill from stock and rest is back order
          fulfillableQuantity = availableStock;
          backOrderQuantity = cartQuantity - availableStock;
        } else {
          // If stock is sufficient, fulfill entire order quantity
          fulfillableQuantity = cartQuantity;
          backOrderQuantity = 0;
        }

        return {
          "productId": item.product.id,
          "name": item.product.name,
          "quantity": fulfillableQuantity,
          "totalAmount": item.totalPrice,
          "price": item.product.price,
          "backOrder": backOrderQuantity,
        };
      }).toList();

      // Construct the full request body
      final Map<String, dynamic> orderBody = {
        // --- FIX: Pass the new userId object instead of a string ---
        "userId": selectedRetailer.id,
        "products": productsPayload,
        "source": "SALES", // Assuming this should be SALES now
        "notes": notesController.text,
        "orderTerms": selectedTerm.value,
        "orderBoxs": totalBox,
        "totalAmount": totalAmount,
      };

      // Call the repository to create the order
      final bool success = await _orderRepository.createOrder(body: orderBody);
      AppPrint.appPrint(success, title: "Order Success");
      if (success) {
        Get.snackbar(
          "Success",
          "Order has been placed successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        cartItems.clear();
        notesController.clear();
        selectedRetailerId.value = null;
        selectedTerm.value = paymentTerms.first;
        Get.close(1);
      } else {
        Get.snackbar(
          "Error",
          "Failed to place order. Please try again.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "An unexpected error occurred: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isPlacingOrder(false);
    }
  }

  // --- Retailer Methods ---
  void fetchRetailers() async {
    try {
      isRetailerLoading(true);
      var retailerList = await _salesRepository.getMyRetailers();
      retailers.assignAll(retailerList);
    } finally {
      isRetailerLoading(false);
    }
  }

  void selectRetailer(String? retailerId) {
    selectedRetailerId.value = retailerId;
  }

  // --- Payment Term Method ---
  void selectTerm(String? term) {
    if (term != null) {
      selectedTerm.value = term;
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

  void incrementQuantity(CartItemModel item) {
    item.quantity.value++;
  }

  void decrementQuantity(CartItemModel item) {
    if (item.quantity.value > 1) {
      item.quantity.value--;
    } else {
      removeItemFromCart(item);
    }
  }

  void removeItemFromCart(CartItemModel item) {
    cartItems.remove(item);
  }

  void removeAllItems() {
    cartItems.clear();
  }

  double get totalAmount =>
      cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  int get totalBox =>
      cartItems.fold(0, (sum, item) => sum + item.quantity.value);
}
