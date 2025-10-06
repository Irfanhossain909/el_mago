import 'package:el_mago/models/retailer_order/retailer_order_model.dart';
import 'package:el_mago/services/repository/retailer_order_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RetailerMyOrderController extends GetxController {
  final RetailerOrderRepository _repository = RetailerOrderRepository();

  // State variables for pagination
  final _masterOrderList = <RetailerOrderModel>[].obs;
  var filteredOrderList = <RetailerOrderModel>[].obs;
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  var page = 1;
  var hasMore = true.obs;

  var selectedOrderId = Rx<String?>(null);

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
      var result = await _repository.getRetailerOrders(page: page);

      // Debug logging
      AppPrint.appPrint('Repository result: $result');
      AppPrint.appPrint('Orders type: ${result['orders'].runtimeType}');

      // FIX: The repository already returns RetailerOrderModel objects, no need to parse again
      final List<RetailerOrderModel> orders = List<RetailerOrderModel>.from(
        result['orders'],
      );
      _masterOrderList.assignAll(orders);
      filteredOrderList.assignAll(orders);
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
      var result = await _repository.getRetailerOrders(page: page);

      // FIX: The repository already returns RetailerOrderModel objects, no need to parse again
      final List<RetailerOrderModel> orders = List<RetailerOrderModel>.from(
        result['orders'],
      );
      _masterOrderList.assignAll(orders);
      filteredOrderList.assignAll(orders);
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
      var result = await _repository.getRetailerOrders(page: page);
      // FIX: The repository already returns RetailerOrderModel objects, no need to parse again
      final List<RetailerOrderModel> orders = List<RetailerOrderModel>.from(
        result['orders'],
      );
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

  void viewOrderDetails(String orderId) {
    selectedOrderId.value = orderId;
  }
}
