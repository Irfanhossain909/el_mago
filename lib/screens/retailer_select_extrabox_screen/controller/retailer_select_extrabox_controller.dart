import 'package:el_mago/models/product_model/product_model.dart';
import 'package:el_mago/models/retailer_model/retailer_dashboard_summary_model.dart';
import 'package:el_mago/models/order_model/extra_box_request_model.dart';
import 'package:el_mago/models/user_model/user_model.dart';
import 'package:el_mago/models/subscription_model/current_subscription_model.dart';
import 'package:el_mago/services/repository/sales_dashboard_repository.dart';
import 'package:el_mago/services/repository/profile_repository.dart';
import 'package:el_mago/services/repository/subscription_repository.dart';
import 'package:el_mago/services/api/get_storage_services.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/get.dart';

// NEW: A model to hold a product and its quantity in the cart.
class CartItem {
  final ProductModel product;
  var quantity = 1.obs;

  CartItem({required this.product});
}

class RetailerSelectExtraboxController extends GetxController {
  // Dynamic subscription data
  var currentSubscription = Rx<CurrentSubscriptionData?>(null);
  var isLoadingSubscription = false.obs;

  var getAllProducts = <ProductModel>[].obs;
  var dashboardSummary = Rx<RetailerDashboardSummaryModel?>(null);
  var isLoading = false.obs;
  var isPlacingOrder = false.obs;

  SalesDashboardRepository salesDashboardRepository =
      SalesDashboardRepository();
  GetStorageServices storageServices = GetStorageServices.instance;
  ProfileRepository profileRepository = ProfileRepository();
  SubscriptionRepository subscriptionRepository =
      SubscriptionRepository.instance;

  // Dynamic getters for subscription data
  int get minimumBoxes => currentSubscription.value?.boxRequired ?? 6;
  String get currentTier =>
      currentSubscription.value?.displayTier ?? "Platinum";
  String get subscriptionTier =>
      currentSubscription.value?.displayBoxRequired ?? "6 boxes per month";

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

  Future<void> fetchCurrentSubscription() async {
    try {
      isLoadingSubscription.value = true;
      final subscriptionData = await subscriptionRepository
          .getCurrentSubscription();

      if (subscriptionData != null) {
        currentSubscription.value = subscriptionData;
        AppPrint.appPrint(
          "Subscription loaded: ${subscriptionData.subscription}, Boxes required: ${subscriptionData.boxRequired}",
        );
      } else {
        AppPrint.appError("Failed to fetch subscription data");
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchCurrentSubscription");
    } finally {
      isLoadingSubscription.value = false;
    }
  }

  @override
  void onInit() {
    fetchAllProducts();
    fetchCurrentSubscription();
    // Initialize user ID in background
    ensureUserIdIsSet();
    super.onInit();
  }

  // --- USER PROFILE AND ID MANAGEMENT ---

  /// Fetch user profile and set userId in storage
  Future<void> fetchAndSetUserProfile() async {
    try {
      final UserModelData? profileData = await profileRepository
          .getProfileData();

      if (profileData != null && profileData.id != null) {
        await storageServices.setUID(profileData.id!);
        AppPrint.appPrint("User ID set in storage: ${profileData.id}");
      } else {
        AppPrint.appError("Failed to get user profile data");
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchAndSetUserProfile");
    }
  }

  /// Ensure userId is set before placing order
  Future<bool> ensureUserIdIsSet() async {
    String userId = storageServices.getUID();

    if (userId.isEmpty) {
      // Try to fetch profile if userId is not in storage
      AppPrint.appPrint("User ID is empty, fetching from profile...");
      await fetchAndSetUserProfile();
      userId = storageServices.getUID();

      if (userId.isEmpty) {
        AppPrint.appError("Failed to get user ID even after fetching profile");
        return false;
      }
    }

    AppPrint.appPrint("User ID confirmed: $userId");
    return true;
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
      if (totalBoxes < minimumBoxes) {
        Get.snackbar(
          "Error",
          "Minimum $minimumBoxes boxes required. Currently selected: $totalBoxes boxes.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }

      // Set loading state
      isPlacingOrder.value = true;

      // Ensure user ID is set (fetch from profile if needed)
      bool userIdSet = await ensureUserIdIsSet();
      if (!userIdSet) {
        Get.snackbar(
          "Error",
          "Unable to get user information. Please login again.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }

      // Get user ID from storage (now guaranteed to be set)
      String userId = storageServices.getUID();

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
      var response = await salesDashboardRepository.placeExtraBoxOrder(
        userId,
        request,
      );

      if (response != null && response['success'] == true) {
        // Success
        Get.snackbar(
          "Success",
          response['message'] ?? "Extra boxes ordered successfully!",
          snackPosition: SnackPosition.BOTTOM,
        );

        // Clear the cart after successful order
        cart.clear();

        AppPrint.appPrint("Order placed successfully: ${response['data']}");
        return true;
      } else {
        // Failure
        Get.snackbar(
          "Error",
          "Failed to place order. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred while placing the order.",
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
