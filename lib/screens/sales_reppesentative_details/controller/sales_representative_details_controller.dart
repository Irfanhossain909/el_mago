import 'package:el_mago/models/order_model/order_history_model.dart';
import 'package:el_mago/models/retailer_order/retailer_analitics.dart';
import 'package:el_mago/models/retailer_order/retailer_details_model.dart';
import 'package:el_mago/services/repository/retailer_order_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/get.dart';

class SalesRepresentativeDetailsController extends GetxController {
  //repository
  RetailerOrderRepository repository = RetailerOrderRepository();

  //variables
  String? retailerId;
  Rxn<RetailerDetailsDataModel> retailerModel = Rxn();
  Rxn<RetailerAnaliticsData> retailerAnaliticsModel = Rxn();
  Rxn<OrderHistoryResponse> orderHistoryResponse = Rxn();
  var isLoading = false.obs;
  var isOrderHistoryLoading = false.obs;

  Future<void> fetchRetailerData() async {
    try {
      isLoading.value = true;
      var response = await repository.getSingleRetailer(
        retailerId: retailerId ?? "",
      );
      if (response != null) {
        retailerModel.value = response;
        AppPrint.apiResponse("Retailer Data: ${retailerModel.value?.image}");
        isLoading.value = false;
      } else {
        AppPrint.appError("Response is null");
        isLoading.value = false;
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchRetailerData");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchRetailerAnalatics({required String retailerId}) async {
    try {
      isLoading.value = true;
      var response = await repository.getSingleUserAnalatics(
        retailerId: retailerId,
      );
      if (response != null) {
        retailerAnaliticsModel.value = response;
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchRetailerAnalatics");
    } finally {
      isLoading.value = false; // লোডিং বন্ধ করা উচিত
    }
  }

  Future<void> fetchOrderHistory({
    required String userId,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      isOrderHistoryLoading.value = true;
      var response = await repository.getRetailerOrderHistory(
        userId: userId,
        page: page,
        limit: limit,
      );
      if (response != null) {
        orderHistoryResponse.value = response;
        AppPrint.apiResponse(
          "Order History fetched: ${response.data.orders.length} orders",
        );
      } else {
        AppPrint.appError("Order history response is null");
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchOrderHistory");
    } finally {
      isOrderHistoryLoading.value = false;
    }
  }
}
