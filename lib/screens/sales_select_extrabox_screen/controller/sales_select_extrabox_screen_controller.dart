import 'package:el_mago/models/product_model/product_model.dart';
import 'package:el_mago/models/sales_model/sales_subscription_model.dart';
import 'package:el_mago/models/order_model/extra_box_request_model.dart';
import 'package:el_mago/services/repository/sales_dashboard_repository.dart';
import 'package:el_mago/services/api/get_storage_services.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/get.dart';

// NEW: A model to hold a product and its quantity in the cart.
class SalesCartItem {
  final ProductModel product;
  var quantity = 1.obs;

  SalesCartItem({required this.product});
}

class SalesSelectExtraboxScreenController extends GetxController {
  // Dynamic subscription data
  var currentSubscription = Rx<SalesSubscriptionData?>(null);
  var isLoadingSubscription = false.obs;

  var getAllProducts = <ProductModel>[].obs;
  var isLoading = false.obs;
  var isPlacingOrder = false.obs;

  // ID of the subscription passed from previous screen
  String subscriptionUserId = '';

  SalesDashboardRepository salesDashboardRepository =
      SalesDashboardRepository();
  GetStorageServices storageServices = GetStorageServices.instance;

  // Dynamic getters for subscription data
  int get minimumBoxes => currentSubscription.value?.boxRequired ?? 0;
  String get currentTier => currentSubscription.value?.displayTier ?? "Unknown";
  String get subscriptionTier =>
      currentSubscription.value?.displayBoxRequired ?? "Unknown boxes";

  // --- NEW CART LOGIC ---

  // List to hold selected products (the cart)
  var cart = <SalesCartItem>[].obs;

  // Check if a product is already in the cart
  bool isProductInCart(ProductModel product) {
    return cart.any((item) => item.product.id == product.id);
  }

  // Toggles a product in and out of the cart
  void toggleProductSelection(ProductModel product) {
    if (isProductInCart(product)) {
      cart.removeWhere((item) => item.product.id == product.id);
    } else {
      cart.add(SalesCartItem(product: product));
    }
  }

  // Increase quantity of a cart item
  void incrementQuantity(SalesCartItem cartItem) {
    cartItem.quantity.value++;
  }

  // Decrease quantity or remove item if quantity is 1
  void decrementQuantity(SalesCartItem cartItem) {
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

  Future<void> fetchSalesSubscription() async {
    try {
      isLoadingSubscription.value = true;
      if (subscriptionUserId.isEmpty) {
        AppPrint.appError("Subscription User ID is empty");
        return;
      }

      final subscriptionData = await salesDashboardRepository
          .getSalesSubscription(subscriptionUserId);

      if (subscriptionData != null) {
        currentSubscription.value = subscriptionData;
        AppPrint.appPrint(
          "Sales subscription loaded: ${subscriptionData.subscription}, Boxes required: ${subscriptionData.boxRequired}",
        );
      } else {
        AppPrint.appError("Failed to fetch sales subscription data");
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchSalesSubscription");
    } finally {
      isLoadingSubscription.value = false;
    }
  }

  // Set the subscription user ID (called from previous screen)
  void setSubscriptionUserId(String userId) {
    subscriptionUserId = userId;
    AppPrint.appPrint("Subscription User ID set to: $userId");
  }

  @override
  void onInit() {
    fetchAllProducts();

    // Get the userId from arguments if passed
    final arguments = Get.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      final userId = arguments['userId'] as String?;
      if (userId != null) {
        setSubscriptionUserId(userId);
        fetchSalesSubscription();
      }
    }

    super.onInit();
  }

  // --- NEW ORDER PLACEMENT LOGIC ---

  /// Validates the cart and places the order
  Future<bool> placeOrder() async {
    try {
      // Validation: Check if cart is not empty
      if (cart.isEmpty) {
        Get.snackbar(
          "Error",
          "Please select at least one product to place the order.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }

      // Validation: Check if total boxes meet minimum requirement
      if (minimumBoxes > 0 && totalBoxes < minimumBoxes) {
        Get.snackbar(
          "Error",
          "Minimum $minimumBoxes boxes required. Currently selected: $totalBoxes boxes.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }

      // Set loading state
      isPlacingOrder.value = true;

      // Check if subscription user ID is set
      if (subscriptionUserId.isEmpty) {
        Get.snackbar(
          "Error",
          "Subscription information is missing. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }

      // Convert cart items to ExtraBoxRequest format
      List<ExtraBoxItem> extraBoxItems = cart.map((cartItem) {
        return ExtraBoxItem(
          productId: cartItem.product.id,
          name: cartItem.product.name,
          size: cartItem.product.size,
          price: cartItem.product.price,
          quantity: cartItem.quantity.value,
        );
      }).toList();

      ExtraBoxRequest request = ExtraBoxRequest(extraBoxes: extraBoxItems);

      // Place the order via API
      var response = await salesDashboardRepository.updateSalesExtraBoxes(
        subscriptionUserId,
        request,
      );

      if (response != null && response['success'] == true) {
        // Success
        Get.snackbar(
          "Success",
          response['message'] ?? "Extra boxes updated successfully!",
          snackPosition: SnackPosition.BOTTOM,
        );

        // Clear the cart after successful order
        cart.clear();

        AppPrint.appPrint(
          "Sales order placed successfully: ${response['data']}",
        );

        // Navigate back to previous screen
        Get.back();
        return true;
      } else {
        // Failure
        Get.snackbar(
          "Error",
          "Failed to update extra boxes. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred while updating the extra boxes.",
        snackPosition: SnackPosition.BOTTOM,
      );
      AppPrint.appError(e, title: "placeOrder");
      return false;
    } finally {
      // Reset loading state
      isPlacingOrder.value = false;
    }
  }
}
