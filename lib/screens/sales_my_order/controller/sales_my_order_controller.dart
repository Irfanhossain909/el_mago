import 'package:el_mago/models/product_model/order_model/order_model.dart';
import 'package:el_mago/services/repository/sales_my_order_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesMyOrderController extends GetxController {
  final MyOrderRepository _repository = Get.find<MyOrderRepository>();

  // Holds the master list of orders fetched from the API
  var _masterOrderList = <OrderModel>[].obs;
  // Holds the filtered list that is displayed in the UI
  var filteredOrderList = <OrderModel>[].obs;

  var isLoading = true.obs;
  var selectedOrder = Rx<OrderModel?>(null);

  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchMyOrders();
    // Add a listener to the search field to trigger filtering
    searchController.addListener(() {
      filterOrders(searchController.text);
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void fetchMyOrders() async {
    try {
      isLoading(true);
      var orders = await _repository.getMyOrders();
      _masterOrderList.assignAll(orders);
      filteredOrderList.assignAll(orders); // Initially, show all orders
    } finally {
      isLoading(false);
    }
  }

  void filterOrders(String query) {
    if (query.isEmpty) {
      // If search is empty, show all orders
      filteredOrderList.assignAll(_masterOrderList);
    } else {
      // Filter by orderId (invoice ID) or by any product name within the order
      var filtered = _masterOrderList.where((order) {
        final queryLower = query.toLowerCase();
        final matchesOrderId = order.orderId.toLowerCase().contains(queryLower);
        final matchesProductName = order.products.any(
          (product) => product.name.toLowerCase().contains(queryLower),
        );
        return matchesOrderId || matchesProductName;
      }).toList();
      filteredOrderList.assignAll(filtered);
    }
  }

  // Method to set the selected order before navigating
  void viewOrderDetails(OrderModel order) {
    selectedOrder.value = order;
    // Navigation will be handled in the UI
  }
}
