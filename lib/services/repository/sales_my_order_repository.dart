import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/models/order_model/order_model.dart';
import 'package:el_mago/models/order_model/commission_order_model.dart';
import 'package:el_mago/services/api/api_services.dart';
import 'package:el_mago/widgets/app_log/error_log.dart';

class MyOrderRepository {
  final ApiServices _apiServices = ApiServices.instance;

  Future<List<OrderModel>> getMyOrders() async {
    try {
      final endpoint = AppApiEndPoint.instance.getMyOrders;
      final response = await _apiServices.apiGetServices(endpoint);

      if (response != null &&
          response['success'] == true &&
          response['data'] != null) {
        final List<dynamic> orderData = response['data'];
        return orderData.map((json) => OrderModel.fromJson(json)).toList();
      } else {
        errorLog('Failed to fetch orders or data is null', '');
        return [];
      }
    } catch (e) {
      errorLog('Exception in getMyOrders', e.toString());
      return [];
    }
  }

  Future<dynamic> getTotalEarnCommision() async {
    try {
      final endpoint = AppApiEndPoint.instance.getTotalEarnCommision;
      final response = await _apiServices.apiGetServices(endpoint);

      if (response != null &&
          response['success'] == true &&
          response['data'] != null) {
        final dynamic orderData = response['data'];
        return orderData;
      } else {
        errorLog('Failed to fetch orders or data is null', '');
        return false;
      }
    } catch (e) {
      errorLog('Exception in getMyOrders', e.toString());
      return false;
    }
  }

  Future<CommissionOrderResponse?> getCommissionOrders({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final endpoint =
          "${AppApiEndPoint.instance.getCommissionOrders}?page=$page&limit=$limit";
      final response = await _apiServices.apiGetServices(endpoint);

      if (response != null && response['success'] == true) {
        return CommissionOrderResponse.fromJson(response);
      } else {
        errorLog('Failed to fetch commission orders or data is null', '');
        return null;
      }
    } catch (e) {
      errorLog('Exception in getCommissionOrders', e.toString());
      return null;
    }
  }
}
