import 'package:el_mago/models/product_model/product_model.dart';
import 'package:el_mago/models/retailer_model/retailer_model.dart';
import 'package:el_mago/screens/controller/global_controller.dart';
import 'package:el_mago/screens/sales_shopping_cart/model/cart_item_model.dart';
import 'package:el_mago/services/repository/sales_repository.dart';
import 'package:get/get.dart';

class SalesShoppingCartController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();
  final SalesRepository _salesRepository = SalesRepository();

  // Observables for cart
  var cartItems = <CartItemModel>[].obs;

  // Observables for retailers dropdown
  var retailers = <RetailerModel>[].obs;
  var isRetailerLoading = true.obs;
  var selectedRetailerId = Rx<String?>(null);

  // --- NEW: Observables for Payment Terms Dropdown ---
  final List<String> paymentTerms = ['Due on Receipt', 'Net 15', 'Net 30'];
  var selectedTerm = 'Due on Receipt'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRetailers();
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

  // --- NEW: Payment Term Method ---
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
