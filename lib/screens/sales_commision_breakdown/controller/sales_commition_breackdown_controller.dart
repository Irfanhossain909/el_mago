import 'package:el_mago/models/order_model/commission_order_model.dart';
import 'package:el_mago/services/repository/sales_my_order_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/state_manager.dart';

class SalesCommitionBreackdownController extends GetxController {
  MyOrderRepository myOrderRepository = MyOrderRepository();

  RxString salesCommitionBreackdown = ''.obs;
  RxList<CommissionOrderModel> commissionOrders = <CommissionOrderModel>[].obs;
  RxList<CommissionOrderModel> filteredOrders = <CommissionOrderModel>[].obs;
  RxString searchQuery = ''.obs;
  RxBool isLoading = true.obs;
  RxBool isLoadingOrders = false.obs;

  // Pagination
  RxInt currentPage = 1.obs;
  RxInt totalPages = 1.obs;
  RxBool hasMoreData = true.obs;

  Future<void> fetchMyOrderTotalEarnings() async {
    try {
      isLoading.value = true;
      var response = await myOrderRepository.getTotalEarnCommision();
      if (response != null) {
        salesCommitionBreackdown.value = response.toString();
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchMyOrderTotalEarnings");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCommissionOrders({bool loadMore = false}) async {
    try {
      if (loadMore) {
        if (!hasMoreData.value) return;
        isLoadingOrders.value = true;
      } else {
        isLoading.value = true;
        currentPage.value = 1;
        commissionOrders.clear();
      }

      var response = await myOrderRepository.getCommissionOrders(
        page: currentPage.value,
        limit: 10,
      );

      if (response != null) {
        if (loadMore) {
          commissionOrders.addAll(response.data);
        } else {
          commissionOrders.assignAll(response.data);
        }

        totalPages.value = response.pagination.totalPage;
        hasMoreData.value = currentPage.value < totalPages.value;

        if (hasMoreData.value) {
          currentPage.value++;
        }

        // Apply search filter
        _filterOrders();
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchCommissionOrders");
    } finally {
      isLoading.value = false;
      isLoadingOrders.value = false;
    }
  }

  void searchOrders(String query) {
    searchQuery.value = query;
    _filterOrders();
  }

  void _filterOrders() {
    if (searchQuery.value.isEmpty) {
      filteredOrders.assignAll(commissionOrders);
    } else {
      final filtered = commissionOrders.where((order) {
        final searchLower = searchQuery.value.toLowerCase();
        final orderIdMatch = order.orderId.toLowerCase().contains(searchLower);
        final productMatch = order.products.any(
          (product) => product.name.toLowerCase().contains(searchLower),
        );
        return orderIdMatch || productMatch;
      }).toList();
      filteredOrders.assignAll(filtered);
    }
  }

  @override
  void onInit() {
    fetchMyOrderTotalEarnings();
    fetchCommissionOrders();
    super.onInit();
  }
}
