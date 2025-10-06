import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/models/order_model/order_model.dart';
import 'package:el_mago/models/order_model/commission_order_model.dart';
import 'package:el_mago/services/api/api_services.dart';
import 'package:el_mago/widgets/app_log/error_log.dart';

class MyOrderRepository {
  final ApiServices _apiServices = ApiServices.instance;

  // Fetches a paginated list of orders for sales
  Future<Map<String, dynamic>> getMyOrders({
    int page = 1,
    String? orderStatus,
  }) async {
    try {
      final endpoint = AppApiEndPoint.instance.getMyOrders;
      Map<String, dynamic> queryParams = {'page': page, 'limit': 10};
      if (orderStatus != null) {
        queryParams['orderStatus'] = orderStatus;
      }
      final response = await _apiServices.apiGetServices(
        endpoint,
        queryParameters: queryParams,
      );

      if (response != null &&
          response['success'] == true &&
          response['data'] != null) {
        final List<dynamic> orderData = response['data'];
        final pagination = response['pagination'];

        // Determine if there are more pages
        final bool hasMore = pagination != null
            ? pagination['page'] < pagination['totalPage']
            : false;

        return {
          'orders': orderData.map((json) => OrderModel.fromJson(json)).toList(),
          'hasMore': hasMore,
        };
      } else {
        errorLog('Failed to fetch orders or data is null', '');
        return {'orders': <OrderModel>[], 'hasMore': false};
      }
    } catch (e) {
      errorLog('Exception in getMyOrders', e.toString());
      return {'orders': <OrderModel>[], 'hasMore': false};
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
