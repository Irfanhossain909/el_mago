import 'package:el_mago/models/order_model/order_model.dart';
import 'package:el_mago/services/repository/sales_my_order_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesMyOrderController extends GetxController {
  final MyOrderRepository _repository = Get.find<MyOrderRepository>();

  // State variables for pagination
  final _masterOrderList = <OrderModel>[].obs;
  var filteredOrderList = <OrderModel>[].obs;
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  var page = 1;
  var hasMore = true.obs;

  var selectedOrder = Rx<OrderModel?>(null);

  // Filter state variables
  var selectedFilter = 'allorder'.obs;
  final List<String> filterOptions = [
    'allorder',
    'pending',
    'processing',
    'shipped',
    'delivered',
  ];

  final List<String> filterLabels = [
    'All Orders',
    'Pending',
    'Processing',
    'Shipped',
    'Delivered',
  ];

  final searchController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchMyOrders(); // Initial fetch
    searchController.addListener(() {
      filterOrders(searchController.text);
    });
    // Add listener to scroll controller for pagination
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasMore.value &&
          !isLoadingMore.value) {
        loadMoreOrders();
      }
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  // Fetches the first page of orders
  void fetchMyOrders() async {
    try {
      isLoading(true);
      page = 1; // Reset page
      hasMore(true); // Reset hasMore
      String? orderStatus = selectedFilter.value == 'allorder'
          ? null
          : selectedFilter.value;
      var result = await _repository.getMyOrders(
        page: page,
        orderStatus: orderStatus,
      );

      // Debug logging
      AppPrint.appPrint('Repository result: $result');
      AppPrint.appPrint('Orders type: ${result['orders'].runtimeType}');

      final List<OrderModel> orders = List<OrderModel>.from(result['orders']);
      _masterOrderList.assignAll(orders);
      // Apply search filter after fetching
      filterOrders(searchController.text);
      hasMore(result['hasMore']);
    } catch (e) {
      AppPrint.appPrint('Error in fetchMyOrders: $e');
      // Handle error gracefully
      _masterOrderList.clear();
      filteredOrderList.clear();
      hasMore(false);
    } finally {
      isLoading(false);
    }
  }

  // Refresh method for pull-to-refresh
  Future<void> refreshOrders() async {
    try {
      page = 1; // Reset page
      hasMore(true); // Reset hasMore
      String? orderStatus = selectedFilter.value == 'allorder'
          ? null
          : selectedFilter.value;
      var result = await _repository.getMyOrders(
        page: page,
        orderStatus: orderStatus,
      );

      final List<OrderModel> orders = List<OrderModel>.from(result['orders']);
      _masterOrderList.assignAll(orders);
      // Re-apply search filter after refresh
      filterOrders(searchController.text);
      hasMore(result['hasMore']);
    } catch (e) {
      AppPrint.appPrint('Error in refreshOrders: $e');
      // Handle error gracefully - don't clear data on refresh error
    }
  }

  // Fetches subsequent pages
  void loadMoreOrders() async {
    if (isLoadingMore.value || !hasMore.value) return;
    try {
      isLoadingMore(true);
      page++;
      String? orderStatus = selectedFilter.value == 'allorder'
          ? null
          : selectedFilter.value;
      var result = await _repository.getMyOrders(
        page: page,
        orderStatus: orderStatus,
      );
      final List<OrderModel> orders = List<OrderModel>.from(result['orders']);
      _masterOrderList.addAll(orders);
      filterOrders(searchController.text); // Re-apply filter
      hasMore(result['hasMore']);
    } catch (e) {
      AppPrint.appPrint('Error in loadMoreOrders: $e');
      // Handle error gracefully
      hasMore(false);
    } finally {
      isLoadingMore(false);
    }
  }

  void filterOrders(String query) {
    if (query.isEmpty) {
      filteredOrderList.assignAll(_masterOrderList);
    } else {
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

  // Handle filter changes
  void onFilterChanged(String filter) {
    selectedFilter.value = filter;
    fetchMyOrders(); // Refetch orders with the new filter
  }
}
