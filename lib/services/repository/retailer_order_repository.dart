import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/models/retailer_model/retailer_subscription_model.dart';
import 'package:el_mago/models/retailer_order/all_retailer_model.dart';
import 'package:el_mago/models/retailer_order/retailer_analitics.dart';
import 'package:el_mago/models/retailer_order/retailer_card_info_model.dart';
import 'package:el_mago/models/retailer_order/retailer_details_model.dart';
import 'package:el_mago/models/retailer_order/retailer_order_model.dart';
import 'package:el_mago/models/retailer_model/retailer_dashboard_summary_model.dart';
import 'package:el_mago/services/api/api_services.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:el_mago/widgets/app_log/error_log.dart';

class RetailerOrderRepository {
  final ApiServices _apiServices = ApiServices.instance;

  // Fetches a paginated list of orders for the retailer
  Future<Map<String, dynamic>> getRetailerOrders({int page = 1}) async {
    try {
      final endpoint = AppApiEndPoint.instance.getMyOrdersRetailer;
      final response = await _apiServices.apiGetServices(
        endpoint,
        queryParameters: {'page': page, 'limit': 10},
      );

      if (response != null &&
          response['success'] == true &&
          response['data'] != null) {
        final List<dynamic> orderData = response['data'];
        final pagination = response['pagination'];

        // Determine if there are more pages
        final bool hasMore = pagination['page'] < pagination['totalPage'];

        return {
          'orders': orderData
              .map((json) => RetailerOrderModel.fromJson(json))
              .toList(),
          'hasMore': hasMore,
        };
      } else {
        errorLog('Failed to fetch retailer orders or data is null', '');
        return {'orders': [], 'hasMore': false};
      }
    } catch (e) {
      errorLog('Exception in getRetailerOrders', e.toString());
      return {'orders': [], 'hasMore': false};
    }
  }

  // Fetches the details for a single order
  Future<RetailerOrderModel?> getSingleRetailerOrder(String orderId) async {
    try {
      final endpoint = AppApiEndPoint.getSingleRetailerOrder(orderId);
      final response = await _apiServices.apiGetServices(endpoint);

      if (response != null &&
          response['success'] == true &&
          response['data'] != null) {
        return RetailerOrderModel.fromJson(response['data']);
      } else {
        errorLog('Failed to fetch single retailer order or data is null', '');
        return null;
      }
    } catch (e) {
      errorLog('Exception in getSingleRetailerOrder', e.toString());
      return null;
    }
  }

  // Fetches the dashboard summary data
  Future<RetailerDashboardSummaryModel?> getRetailerDashboardSummary() async {
    try {
      final endpoint = AppApiEndPoint.instance.getRetailerDashboardSummary;
      final response = await _apiServices.apiGetServices(endpoint);

      if (response != null &&
          response['success'] == true &&
          response['data'] != null) {
        return RetailerDashboardSummaryModel.fromJson(response['data']);
      } else {
        errorLog(
          'Failed to fetch retailer dashboard summary or data is null',
          '',
        );
        return null;
      }
    } catch (e) {
      errorLog('Exception in getRetailerDashboardSummary', e.toString());
      return null;
    }
  }

  //Fetched All retailers
  Future<List<AlLRetailerModelData>> getAllRetailers() async {
    List<AlLRetailerModelData> allRetailerModel = <AlLRetailerModelData>[];
    try {
      var response = await _apiServices.apiGetServices(
        AppApiEndPoint.instance.getMyRetailers,
      );
      if (response != null) {
        if (response["data"] != null && response["data"] is List) {
          for (var item in response["data"]) {
            allRetailerModel.add(AlLRetailerModelData.fromJson(item));
          }
        }
      } else {
        AppPrint.appError("response is null");
      }
    } catch (e) {
      AppPrint.appError(e, title: "getAllRetailers");
    }
    return allRetailerModel;
  }

  Future<RetailerDetailsDataModel?> getSingleRetailer({
    required String retailerId,
  }) async {
    var url = "${AppApiEndPoint.instance.getMyRetailers}$retailerId";
    try {
      var response = await _apiServices.apiGetServices(url);
      if (response != null && response["data"] != null) {
        // Handle both cases: when API returns a single object or a list
        if (response["data"] is List) {
          List<dynamic> dataList = response["data"];
          if (dataList.isNotEmpty) {
            return RetailerDetailsDataModel.fromJson(dataList.first);
          } else {
            AppPrint.appError("getSingleRetailer: Data list is empty");
            return null;
          }
        } else if (response["data"] is Map<String, dynamic>) {
          return RetailerDetailsDataModel.fromJson(response["data"]);
        } else {
          AppPrint.appError(
            "getSingleRetailer: Unexpected data format - ${response["data"].runtimeType}",
          );
          return null;
        }
      } else {
        AppPrint.appError("SingleUser response is null");
      }
    } catch (e) {
      AppPrint.appError(e, title: "getSingleRetailer");
    }
    return null;
  }

  Future<bool> createRetailer({
    required String salesRepId,
    required String name,
    required String email,
    required String address,
    required String cardHolderName,
    required String cardNumber,
    required String expiryDate,
    required String cvv,
    required String zipCode,
  }) async {
    Map<String, dynamic> card = {
      "cardHolderName": cardHolderName,
      "cardNumber": cardNumber,
      "expiryDate": expiryDate,
      "cvv": cvv,
      "zipCode": zipCode,
    };

    Map<String, dynamic> body = {
      "salesRepId": salesRepId,
      "name": name,
      "email": email,
      "address": address,
      "card": card,
    };

    try {
      var response = await _apiServices.apiPostServices(
        url: AppApiEndPoint.instance.createRetailer,
        body: body,
      );
      if (response != null) {
        return true;
      } else {
        AppPrint.appError("CreateRetailer null");
        return false;
      }
    } catch (e) {
      AppPrint.appError(e, title: "createRetailer");
    }
    return false;
  }

  Future<bool> deleteRetailer({required String retailerId}) async {
    try {
      var response = await _apiServices.apiDeleteServices(
        url: "${AppApiEndPoint.instance.deleteRetailer}$retailerId",
      );
      if (response != null) {
        return true;
      } else {
        AppPrint.appError("DeleteRetailer null");
        return false;
      }
    } catch (e) {
      AppPrint.appError(e, title: "deleteRetailer");
    }
    return false;
  }

  Future<RetailerAnaliticsData?> getSingleUserAnalatics({
    required String retailerId,
  }) async {
    var url =
        "${AppApiEndPoint.instance.getSingleRetailerDetailsAnalysis}$retailerId";
    try {
      var response = await _apiServices.apiGetServices(url);
      if (response != null && response["data"] != null) {
        return RetailerAnaliticsData.fromJson(response["data"]);
      } else {
        AppPrint.appError("SingleUser response is null");
        return null;
      }
    } catch (e) {
      AppPrint.appError(e, title: "getSingleUserAnalatics");
    }
    return null;
  }

  Future<RetailerCardInfoModelData?> getRetailerCardInfo({
    required String retailerId,
  }) async {
    var url =
        "${AppApiEndPoint.instance.getSingleRetailerCardDetails}$retailerId";
    try {
      var response = await _apiServices.apiGetServices(url);
      if (response != null && response["data"] != null) {
        return RetailerCardInfoModelData.fromJson(response["data"]);
      } else {
        AppPrint.appError("getRetailerCardInfo null");
      }
    } catch (e) {
      AppPrint.appError(e, title: "getRetailerCardInfo");
    }
    return null;
  }

  Future<bool> updateRetailer({
    required String retailerId,
    required String name,
    required String phone,
    required String address,
    required String cardHolderName,
    required String cardNumber,
    required String expiryDate,
    required String cvv,
    required String zipCode,
  }) async {
    Map<String, dynamic> card = {
      "cardHolderName": cardHolderName,
      "cardNumber": cardNumber,
      "expiryDate": expiryDate,
      "cvv": cvv,
      "zipCode": zipCode,
    };

    Map<String, dynamic> body = {
      "name": name,
      "phone": phone,
      "address": address,
      "card": card,
    };
    var url =
        "${AppApiEndPoint.instance.updateSingleRetailerCardDetails}$retailerId";
    try {
      var response = await _apiServices.apiPatchServices(url: url, body: body);
      if (response != null) {
        return true;
      } else {
        AppPrint.appError("CreateRetailer null");
        return false;
      }
    } catch (e) {
      AppPrint.appError(e, title: "createRetailer");
    }
    return false;
  }

  Future<List<RetailerSubscriptionModelData>> getRetailerSubscription() async {
    List<RetailerSubscriptionModelData> retailerSubsCription =
        <RetailerSubscriptionModelData>[];

    try {
      var response = await _apiServices.apiGetServices(
        AppApiEndPoint.instance.getSalesAllretailerSubcription,
      );
      if (response != null) {
        if (response["data"] != null && response["data"] is List) {
          for (var item in response["data"]) {
            retailerSubsCription.add(
              RetailerSubscriptionModelData.fromJson(item),
            );
          }
        }
      } else {
        AppPrint.appError("getRetailerSubscription null");
      }
    } catch (e) {
      AppPrint.appError(e, title: "getRetailerSubscription");
    }
    return retailerSubsCription;
  }
}
