import 'package:el_mago/models/product_model/product_model.dart';
import 'package:el_mago/models/user_model/user_model.dart';
import 'package:el_mago/screens/sales_shopping_cart/model/cart_item_model.dart';
import 'package:el_mago/services/api/get_storage_services.dart';
import 'package:el_mago/services/repository/order_repository.dart';
import 'package:el_mago/services/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RetailerShoppingCartController extends GetxController {
  var cartItems = <CartItemModel>[].obs;
  var isPlacingOrder = false.obs;

  // Dropdown management
  var paymentTerms = ["Due on Receipt", "Net 30", "Net 15"].obs;
  var selectedTerm = "Due on Receipt".obs;

  // Services and repositories
  final GetStorageServices _storageServices = GetStorageServices.instance;
  final ProfileRepository _profileRepository = ProfileRepository();
  final OrderRepository _orderRepository = OrderRepository();

  @override
  void onInit() {
    super.onInit();
  }

  // Get current user ID from storage
  String getUserId() {
    return _storageServices.getUID();
  }

  // Update selected payment term
  void updateSelectedTerm(String? newTerm) {
    if (newTerm != null) {
      selectedTerm.value = newTerm;
    }
  }

  // Fetch user profile and set userId in storage
  Future<void> fetchAndSetUserProfile() async {
    try {
      final UserModelData? profileData = await _profileRepository
          .getProfileData();

      if (profileData != null && profileData.id != null) {
        await _storageServices.setUID(profileData.id!);
      }
    } catch (e) {
      print('Error fetching profile: $e');
    }
  }

  // Ensure userId is set before placing order
  Future<bool> ensureUserIdIsSet() async {
    String userId = getUserId();

    if (userId.isEmpty) {
      // Try to fetch profile if userId is not in storage
      await fetchAndSetUserProfile();
      userId = getUserId();
    }

    return userId.isNotEmpty;
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

  // --- Place Order Logic ---
  Future<void> placeOrder() async {
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

      // Ensure userId is set in storage
      final bool userIdAvailable = await ensureUserIdIsSet();

      if (!userIdAvailable) {
        Get.snackbar(
          "Error",
          "Unable to authenticate user. Please login again.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Construct the products list for the request body
      final List<Map<String, dynamic>> productsPayload = cartItems.map((item) {
        return {
          "productId": item.product.id,
          "name": item.product.name,
          "quantity": item.quantity.value,
          "totalAmount": item.totalPrice,
          "price": item.product.price,
        };
      }).toList();

      // Get current user ID (now guaranteed to be available)
      final String userId = getUserId();

      // Construct the full request body
      final Map<String, dynamic> orderBody = {
        "userId": userId,
        "products": productsPayload,
        "source": "Retailer",
        "orderTerms": selectedTerm.value,
        "orderBoxs": totalBoxCount,
        "totalAmount": totalAmount,
      };

      // Call the repository to create the order
      final bool success = await _orderRepository.createOrder(body: orderBody);

      if (success) {
        Get.snackbar(
          "Success",
          "Order has been placed successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        cartItems.clear();
        selectedTerm.value = paymentTerms.first;
        Get.back();
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
}
